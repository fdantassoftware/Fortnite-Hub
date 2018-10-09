//
//  Extensions.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func setRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
