//
//  MainVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import Charts
import GSMessages

class MainVC: UIViewController {
    
    @IBOutlet weak var searchBtn: UIButtonX!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var usernameTextField: TextFieldx!
    private var modesData = [Mode]()
    private var modes = ["Solos", "Duos", "Squads"]
    @IBOutlet weak var contentCollection: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerTag: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var totalKillsLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    private var segmentControl = UISegmentedControl()
    private var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    private let horizontalBarView = UIView()
    private var playerViewModel = PlayerDataViewModel()
    private var platform = "pc"
    var comesFromSettings = false
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        contentCollection.delegate = self
        contentCollection.dataSource = self
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        setBar()
        //Here we selected our first item by default
        contentCollection.bounces = false
        let selectedIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .bottom)
        setTextFieldLeftField(textField: usernameTextField)
        handleplayerState()
    
    }
    
    
    func fetchData() {
        guard let username = UserDefaults.standard.string(forKey: "username") else {return}
        guard let platform = UserDefaults.standard.string(forKey: "platform") else {return}
        self.startLoadingAnimation(loadingMessage: "")
        playerViewModel.getUserID(id: username, platform: platform, endPoint: .userID())
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "comesFromSettings") {
            fetchData()
            noDataView.isHidden = false
            contentView.isHidden = true
            UserDefaults.standard.removeObject(forKey: "comesFromSettings")
        }
    }
 
    func handleplayerState() {
        if UserDefaults.standard.bool(forKey: "isUserSet") {
            fetchData()
            noDataView.isHidden = true
            contentView.isHidden = false
        } else {
            noDataView.isHidden = false
            contentView.isHidden = true
        }
    }
    
  
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        usernameTextField.resignFirstResponder()
        self.startLoadingAnimation(loadingMessage: "")
        if (usernameTextField.text?.isEmpty)! {
            self.showMessage("Username cannot be empty", type: .error)
        } else {
            playerViewModel.getUserID(id: usernameTextField.text!, platform: self.platform, endPoint: .userID())
        }
    }

    func setTextFieldLeftField(textField: UITextField) {
        segmentControl.insertSegment(withTitle: "Epic", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Xbox", at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "PS4", at: 2, animated: true)
        segmentControl.frame =  CGRect(x: 2, y: 0, width: 100, height: 24)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = UIColor.orange
        segmentControl.tintColor = .clear
        segmentControl.layer.cornerRadius = 8
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 16),
            NSAttributedString.Key.foregroundColor: UIColor().setRGB(r: 210, g: 210, b: 210)
            ], for: .normal)
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "DINCondensed-Bold", size: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
            ], for: .selected)
        
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your Epic Games ID...",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor().setRGB(r: 170, g: 170, b: 170)])
        

        searchBtn.backgroundColor = UIColor.orange
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        textField.leftView = segmentControl
        textField.leftViewMode = .always
    }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            platform = "pc"
            searchBtn.backgroundColor = UIColor.orange
            segmentControl.backgroundColor = UIColor.orange
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Epic Games ID...",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor().setRGB(r: 170, g: 170, b: 170)])
        case 1:
            searchBtn.backgroundColor = UIColor().setRGB(r: 53, g: 117, b: 38)
            platform = "xb1"
            segmentControl.backgroundColor = UIColor().setRGB(r: 53, g: 117, b: 38)
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Xbox ID...",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor().setRGB(r: 170, g: 170, b: 170)])
        case 2:
            searchBtn.backgroundColor = UIColor().setRGB(r: 61, g: 109, b: 175)
            platform = "ps4"
             segmentControl.backgroundColor = UIColor().setRGB(r: 61, g: 109, b: 175)
             usernameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your Playstation ID...",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor().setRGB(r: 170, g: 170, b: 170)])
        default:
            break
        }
    }

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == contentCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatsCell", for: indexPath) as? StatsCell {
                let mode = modesData[indexPath.row]
                cell.configureCell(mode: mode)
                return cell
            } else {
                 return UICollectionViewCell()
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell {
                let mode = modes[indexPath.row]
                cell.configureCell(mode: mode)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == contentCollection {
            return modesData.count
        } else {
            return modes.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == contentCollection {
            return CGSize(width: contentCollection.frame.width, height: contentCollection.frame.height)
        } else {
            return CGSize(width: UIScreen.main.bounds.width / 3, height: collectionView.frame.height)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == contentCollection {
           
        } else {
            scrollToMenuIndex(index: indexPath.row)
        }
   
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / UIScreen.main.bounds.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func scrollToMenuIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        contentCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    
    func setBar() {
        horizontalBarView.backgroundColor = UIColor().setRGB(r: 254, g: 245, b: 82)
        self.collectionView.addSubview(horizontalBarView)
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.collectionView.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.topAnchor.constraint(equalTo: self.collectionView.topAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1/3).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    
    func updateUI(data: PlayerData) {
        totalScoreLabel.text = data.totals?.score != nil ? String(data.totals!.score!) : "0"
        totalKillsLabel.text = data.totals?.kills != nil ? String(data.totals!.kills!) : "0"
        playerTag.text = data.username != nil ? data.username!.capitalized : "-"
        platformLabel.text = data.platform != nil ? data.platform!.uppercased() : "pc"
    }

}


extension MainVC: PlayerDataProtocol {
    
    func didGetValidData(Playerdata: PlayerData, modeData: [Mode]) {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            self.updateUI(data: Playerdata)
            self.modesData = modeData
            self.contentCollection.reloadData()
            self.noDataView.isHidden = true
            self.contentView.isHidden = false
            print(Playerdata.username!)
            print(self.platform)
            UserDefaults.standard.set(true, forKey: "isUserSet")
            UserDefaults.standard.set(Playerdata.username!, forKey: "username")
            UserDefaults.standard.set(self.platform, forKey: "platform")
        }
        
    }
    
    
    
    func didFailToParseData(error: String) {
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
            self.stopLoadingAnimation()
        }
    }
    
    func RequestDidFail(error: String) {
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
            self.stopLoadingAnimation()
        }
    }
    
    
}


extension MainVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}
