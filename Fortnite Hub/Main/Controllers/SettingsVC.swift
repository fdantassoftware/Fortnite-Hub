//
//  SettingsVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 17/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import MessageUI

class SettingsVC: UIViewController {

    @IBOutlet weak var supportView: UIView!
    @IBOutlet weak var playerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerGesture = UITapGestureRecognizer(target: self, action: #selector(handleplayerTap))
        playerView.addGestureRecognizer(playerGesture)
        let mailGesture = UITapGestureRecognizer(target: self, action: #selector(handleMailTap))
        supportView.addGestureRecognizer(mailGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Tap action
    @objc func handleplayerTap() {
        UserDefaults.standard.removeObject(forKey: "isUserSet")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "platform")
        UserDefaults.standard.set(true, forKey: "comesFromSettings")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMailTap() {
       sendMail(to: "dantasdeveloper@gmail.com")
    }
    

}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    
    func sendMail(to: String) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients([to])
        composeVC.setSubject("Support Ticket")
        composeVC.setMessageBody("Type your message here", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}
