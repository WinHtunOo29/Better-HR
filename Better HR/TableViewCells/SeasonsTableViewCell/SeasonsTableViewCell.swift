//
//  SeasonsTableViewCell.swift
//  Better HR
//
//  Created by Win Htun Oo on 21/03/2024.
//

import UIKit

class SeasonsTableViewCell: UITableViewCell {
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func render(season: String, episodeCount: Int) {
        seasonLabel.text = season
        episodeCountLabel.text = String(episodeCount)
    }
}
