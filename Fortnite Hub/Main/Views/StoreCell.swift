//
//  StoreCell.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import Kingfisher

class StoreCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var colorView: UIViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(items: Items, index: IndexPath) {
        
        if index.row % 2 == 0 {
            self.backgroundColor = UIColor().setRGB(r: 52, g: 26, b: 83)
        } else {
            self.backgroundColor = UIColor().setRGB(r: 74, g: 26, b: 107)
        }
        name.text = items.name
        cost.text = items.cost
        type.text = items.item.type
        let url = URL(string: items.item.image)
        mainImage.kf.setImage(with: url)
        colorView.backgroundColor = UIColor().rarity(value: items.item.rarity)
        
    }


}
