//
//  MenuCell.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var modeLabel: UILabel!
    
    
    override var isHighlighted: Bool {
        didSet {
            modeLabel.textColor = isHighlighted ? UIColor.white  : UIColor().setRGB(r: 180, g: 180, b: 180)
           
        }
    }
    
    override var isSelected: Bool {
        didSet {

            modeLabel.textColor = isSelected ? UIColor.white : UIColor().setRGB(r: 180, g: 180, b: 180)
            
            
            // 81 17 111
            
            
            // 39 17 59
        }
    }
    
    func configureCell(mode: String) {
        modeLabel.text = mode
    }
    
    
}
