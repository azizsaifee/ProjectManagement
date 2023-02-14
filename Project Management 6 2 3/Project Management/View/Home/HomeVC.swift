//
//  Home.swift
//  Project Management
//
//  Created by Apple on 03/02/23.
//
import WebKit
import UIKit

class HomeVC: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblWebsite: UIView!
    @IBOutlet weak var lblWebapp: UIView!
    @IBOutlet weak var lblApple: UIView!
    @IBOutlet weak var lblSalesforce: UIView!
    @IBOutlet weak var lblAndroid: UIView!
    @IBOutlet weak var lblFlutter: UIView!
    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var floatingViewCollection: [UIView]!
    @IBOutlet weak var viewBelowFloatingView: UIView!
    
    // MARK: View Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        tapOnButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: Required Methods
    func tapOnButton() {
        // for apple button.
        let apple = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        apple.name = "apple"
        lblApple.addGestureRecognizer(apple)
        
        // for android button.
        let android = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        android.name = "android"
        lblAndroid.addGestureRecognizer(android)
        
        // for salesforce button.
        let salesforce = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        salesforce.name = "salesforce"
        lblSalesforce.addGestureRecognizer(salesforce)
        
        // for flutter button.
        let flutter = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        flutter.name = "flutter"
        lblFlutter.addGestureRecognizer(flutter)
        
        // for webapp button.
        let webapp = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        webapp.name = "webapp"
        lblWebapp.addGestureRecognizer(webapp)
        
        // for website button.
        let website = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        website.name = "website"
        lblWebsite.addGestureRecognizer(website)
    }
    
    @objc func buttonTapped(sender: UITapGestureRecognizer) {
        switch sender.name {
        case "apple":
            let iOSVC = self.storyboard?.instantiateViewController(withIdentifier: "iOSVC") as! iOSVC
            self.navigationController?.pushViewController(iOSVC, animated: true)
            iOSVC.title = "IOS Apps"
        case "android":
            let androidVC = self.storyboard?.instantiateViewController(withIdentifier: "AndroidVC") as! AndroidVC
            self.navigationController?.pushViewController(androidVC, animated: true)
            androidVC.title = "Android Apps"
        case "salesforce" :
            let salesforceVC = self.storyboard?.instantiateViewController(withIdentifier: "SalesforceVC") as! SalesforceVC
            self.navigationController?.pushViewController(salesforceVC, animated: true)
            salesforceVC.title = "Salesforce"
        case "flutter":
            let flutterVC = self.storyboard?.instantiateViewController(withIdentifier: "FlutterVC") as! FlutterVC
            self.navigationController?.pushViewController(flutterVC, animated: true)
            flutterVC.title = "Flutter Apps"
        case "website" :
            let websiteVC = self.storyboard?.instantiateViewController(withIdentifier: "WebsiteVC") as! WebsiteVC
            self.navigationController?.pushViewController(websiteVC, animated: true)
            websiteVC.title = "Websites"
        case "webapp":
            let webappVC = self.storyboard?.instantiateViewController(withIdentifier: "WebappVC") as! WebappVC
            self.navigationController?.pushViewController(webappVC, animated: true)
            webappVC.title = "WebApps"
        case .none:
            print("none")
        case .some(_):
            print("none")
        }
    }
        
    func design() {
        for view in viewCollection {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 5, height: 5)
            view.layer.shadowRadius = 5
            view.subviews.first!.layer.cornerRadius = 35
            view.subviews.first!.clipsToBounds = true
            self.animate(with: view)
        }
    }
    
    func animate(with viewBelowFloatingView: UIView) {
        let animator = UIViewPropertyAnimator(duration: 4.0, curve: .linear) {
            viewBelowFloatingView.subviews.first!.center = self.getRandomPoint(of: viewBelowFloatingView)
        }
        animator.startAnimation()
        animator.addCompletion { position in
            if position == .end {
                self.animate(with: viewBelowFloatingView)
            }
        }
    }
    
    func getRandomPoint(of view: UIView) -> CGPoint {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let randomX = CGFloat.random(in: 35...screenWidth - 35)
        let randomY = CGFloat.random(in: 35...screenHeight - 35)
        
        return CGPoint(x: randomX, y: randomY)
    }
}

