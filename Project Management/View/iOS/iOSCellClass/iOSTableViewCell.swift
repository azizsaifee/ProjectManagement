//
//  iOSTableViewCell.swift
//  Project Management
//
//  Created by Apple on 07/02/23.
//

import UIKit

class iOSTableViewCell: UITableViewCell {

    static var arrayOfAppNames: [String] = ["SendBit", "StanBic", "Eco Bank", "DTB-KE", "DTB-TZ", "DTB-UG", "Appylar"]
    
    var arrayOfAppImages: [String] = ["SendBit", "Stanbic", "Eco Bank", "DTB-Logo", "DTB-Logo", "DTB-Logo", "Common"]
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var lblAppIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "iOSTableViewCell", bundle: nil)
    }
    
    func configure(with Index: Int) {
        print(index)
        lblAppName.text = iOSTableViewCell.arrayOfAppNames[Index]
        lblAppIcon.image = UIImage(named: arrayOfAppImages[Index])
    }
}
