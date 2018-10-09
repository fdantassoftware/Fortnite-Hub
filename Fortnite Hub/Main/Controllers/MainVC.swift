//
//  MainVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var modes = ["Solos", "Duos", "Squads"]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerTag: UILabel!
    @IBOutlet weak var contentView: UIView!
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    let horizontalBarView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        setBar()
        //Here we selected our first item by default
        let selectedIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex, animated: false, scrollPosition: .bottom)
    }

}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell {
            let mode = modes[indexPath.row]
            cell.configureCell(mode: mode)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.row) * self.collectionView.frame.width / 3
       horizontalBarLeftAnchorConstraint?.constant = x
        UIView.animate(withDuration: 0.6) {
            self.collectionView.layoutIfNeeded()
        }
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
    
   
    
  
}
