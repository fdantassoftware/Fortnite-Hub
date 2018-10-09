//
//  MenuBar.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 09/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func awakeFromNib() {
        addSubview(collectionView)
        setupConstraints()
        collectionView.backgroundColor = UIColor.red
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        setupConstraints()
        collectionView.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    }
  
}
