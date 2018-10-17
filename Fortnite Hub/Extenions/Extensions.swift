//
//  Extensions.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIColor {
    func setRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


extension UIViewController: NVActivityIndicatorViewable {
    func startLoadingAnimation(loadingMessage: String?) {
        let size = CGSize(width: 70, height: 70)
        let type = NVActivityIndicatorType.circleStrokeSpin
        startAnimating(size, message: loadingMessage, messageFont: nil, type: type, color: UIColor.red, padding: 0, displayTimeThreshold: 0, minimumDisplayTime: 0, backgroundColor: nil, textColor: UIColor.white)
        
    }
    
    func stopLoadingAnimation() {
        self.stopAnimating()
    }
}

extension Double {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// Date given a string

extension String
{
    func  toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self)
        {
            return date
        }
        print("Invalid arguments ! Returning Current Date . ")
        return Date()
    }
}

extension UIColor {
    
    func rarity(value: String) -> UIColor {
        switch value {
        case "epic":
            return UIColor().setRGB(r: 120, g: 27, b: 126)
        case "rare":
            return  UIColor().setRGB(r: 61, g: 105, b: 246)
        case "uncommon":
            return  UIColor().setRGB(r: 56, g: 125, b: 34)
        case "legendary":
            return  UIColor().setRGB(r: 209, g: 195, b: 72)
        case "common":
            return  UIColor().setRGB(r: 179, g: 179, b: 179)
        default:
            return UIColor.white
        }
    }
  
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
