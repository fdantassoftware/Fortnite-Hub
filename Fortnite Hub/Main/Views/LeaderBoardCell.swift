//
//  LeaderBoardCell.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

  
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurecell(leader: Leaderboard, index: IndexPath) {
       mainImage.image = UIImage(named: "\(index.row).png")
        if index.row % 2 == 0 {
            self.backgroundColor = UIColor().setRGB(r: 52, g: 26, b: 83)
        } else {
            self.backgroundColor = UIColor().setRGB(r: 74, g: 26, b: 107)
        }
        username.text = leader.username
        wins.text = "\(leader.wins!) Wins"
        kills.text = "\(leader.kills!) Kills"
        platform.text = String(leader.platform)
    }

}
