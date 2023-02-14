//
//  DetailsVC.swift
//  Project Management
//
//  Created by Apple on 08/02/23.
//

import UIKit

class DetailsVC: UIViewController {
    
    static var objRepository = AppDataRepository()
    static var stringForTitle: String?
    
    @IBOutlet var ViewBelowFloatingViewCollection: [UIView]!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelForTittle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblFeaturesView: UIView!
    @IBOutlet weak var lblDocumentation: UIView!
    @IBOutlet weak var lblCredentialsView: UIView!
    @IBOutlet weak var lblIssuesView: UIView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        sender.setTitle("<iosApps", for: .normal)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForTittle.text = DetailsVC.stringForTitle
        designingViews()
        handlingClicksOnFloatingView()
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: headerView.frame.width - 20, height: headerView.frame.height))
        headerLabel.text = "Recents"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .black
        
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
        
        if DetailsVC.objRepository.get(byIdentifier: "EcoBank") == nil {
            DetailsVC.objRepository.create(data: dataOfEcoBank)
        } else {
            if DetailsVC.objRepository.get(byIdentifier: "EcoBank")! != dataOfEcoBank {
                print("Both are different")
                let deleteSuccessOrNot = DetailsVC.objRepository.delete(byIdentifier: "EcoBank")
                print(deleteSuccessOrNot)
                DetailsVC.objRepository.create(data: dataOfEcoBank)
            } else {
                print("Both are equal.")
            }
        }
    }
    
    func designingViews() {
        for view in ViewBelowFloatingViewCollection {
            view.subviews.first!.layer.borderWidth = 2
            view.subviews.first!.layer.borderColor = UIColor.black.cgColor
            view.subviews.first!.layer.cornerRadius = 40
            view.subviews.first!.clipsToBounds = true
            self.animate(with: view)
        }
    }
    
    func animate(with viewBelowfloatingView: UIView) {
        let animator = UIViewPropertyAnimator(duration: 4.0, curve: .linear) {
            viewBelowfloatingView.subviews.first!.center = self.getRandomPoint(of: viewBelowfloatingView)
        }
        animator.startAnimation()
        animator.addCompletion {
            position in
            if position == .end {
                self.animate(with: viewBelowfloatingView)
            }
        }
    }
    
    func getRandomPoint(of view: UIView) -> CGPoint {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let randomX = CGFloat.random(in: 40...screenWidth - 40)
        let randomY = CGFloat.random(in: 40...screenHeight - 40)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    func handlingClicksOnFloatingView() {
        // for description.
        let documentation = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        documentation.name = "documentation"
        lblDocumentation.addGestureRecognizer(documentation)
        
        // for issues.
        let issues = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        issues.name = "issues"
        lblIssuesView.addGestureRecognizer(issues)
        
        // for credentials.
        let credentials = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        credentials.name = "credentials"
        lblCredentialsView.addGestureRecognizer(credentials)
        
        // for features.
        let features = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        features.name = "features"
        lblFeaturesView.addGestureRecognizer(features)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let viewInsideDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewInsideDetailsVC") as! ViewAfterDetailsVC
        switch sender.name {
        case "documentation" :
            ViewAfterDetailsVC.stringForTitle = "Documentation"
            self.navigationController?.pushViewController(viewInsideDetailsVC, animated: true)
            
        case "features" :
            self.navigationController?.pushViewController(viewInsideDetailsVC, animated: true)
            ViewAfterDetailsVC.stringForTitle = "Features"
        case "credentials" :
            self.navigationController?.pushViewController(viewInsideDetailsVC, animated: true)
            ViewAfterDetailsVC.stringForTitle = "Credentials"
        case "issues" :
            self.navigationController?.pushViewController(viewInsideDetailsVC, animated: true)
            ViewAfterDetailsVC.stringForTitle = "Issues"
        case .none:
            print("none")
        case .some(_):
            print("none")
        }
    }
}
