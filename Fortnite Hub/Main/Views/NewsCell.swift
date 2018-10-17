//
//  NewsCell.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mainimage: UIImageView!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(news: News, index: IndexPath) {
        title.text = news.title
        body.text = news.body
        
        
        let unixTimestamp = Double(news.time)
        let lastDate = Date(timeIntervalSince1970: unixTimestamp!)
        let stringFromLastDate = lastDate.toString(dateFormat: "MMM dd, yyyy")
        date.text = stringFromLastDate
        
        let url = URL(string: news.image)
        mainimage.kf.setImage(with: url)
        
    }


}
