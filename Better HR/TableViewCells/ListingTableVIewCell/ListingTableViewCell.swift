//
//  ListingTableViewCell.swift
//  Better HR
//
//  Created by Win Htun Oo on 20/03/2024.
//

import UIKit
import SDWebImage

class ListingTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemTeal.cgColor
    }
    
    func render(title: String, releaseDate: String, banner: String) {
        bannerImage.sd_setImage(with: URL(string: banner))
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
    }
}
