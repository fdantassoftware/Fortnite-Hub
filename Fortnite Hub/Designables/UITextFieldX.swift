//
//  UITextFieldX.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 16/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//


import UIKit

@IBDesignable
class TextFieldx: UITextField {
    
    
    // Left Button
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
  
    
    @IBInspectable var bottomPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftButtonWith: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable var leftButtonHeight: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftButtonTitle: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftBtnFontSize: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftButtonCornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftButtonBorderW: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftButtonBorderColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftBtnBGColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftBtnTextColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
 
    
    
    func updateView() {
        
        leftViewMode = .always
        let btn = UIButton(frame: CGRect(x: leftPadding, y: 0, width: leftButtonWith, height: leftButtonHeight))
        btn.setTitle(leftButtonTitle, for: .normal)
        btn.layer.cornerRadius = leftButtonCornerRadius
        btn.layer.borderWidth = leftButtonBorderW
        btn.layer.borderColor = leftButtonBorderColor.cgColor
        btn.backgroundColor = leftBtnBGColor
        btn.titleLabel?.textColor = leftBtnTextColor
        btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: leftBtnFontSize)
        btn.addTarget(self, action: #selector(self.leftButtonPressed), for: .touchUpInside)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: leftButtonWith + 10, height: leftButtonHeight))
        view.addSubview(btn)
        leftView = view
    }
    
    @objc func leftButtonPressed(button: UIButton) {
        
        
    }
    
//    @IBInspectable var doneAccessory: Bool{
//        get{
//            return self.doneAccessory
//        }
//        set (hasDone) {
//            if hasDone{
//                addDoneButtonOnKeyboard()
//            }
//        }
//    }
    
    // Custom Done button
    
//    func addDoneButtonOnKeyboard() {
//        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        doneToolbar.barStyle = .default
//        doneToolbar.backgroundColor =  UIColor().setRGB(r: 210, g: 131, b: 103)
//        doneToolbar.barTintColor = UIColor().setRGB(r: 210, g: 131, b: 103)
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
//        let attrs = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 18)!
//        ]
//        done.setTitleTextAttributes(attrs, for: .normal)
//        let items = [flexSpace, done]
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//
//        self.inputAccessoryView = doneToolbar
//    }
//
    @objc func doneButtonAction() {

        self.resignFirstResponder()
    }
    
}
