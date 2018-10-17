//
//  NewsVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    private var newsArray = [News]()
    private let refreshControl = UIRefreshControl()
    var newsViewsModel = NewsViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        newsViewsModel.delegate = self
        self.startLoadingAnimation(loadingMessage: nil)
        fecthNews()
        // Do any additional setup after loading the view.
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
    }
    
    @objc private func refreshNews(_ sender: Any) {
        // Fetch News
        fecthNews()
    }
    
    
    func fecthNews() {
        newsViewsModel.fetchNews(endPoint: .news())
    }
   
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            let news = newsArray[indexPath.row]
            cell.configureCell(news: news, index: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}

extension NewsVC: NewsProtocol {
    func didGetValidData(data: NewsResult) {
        DispatchQueue.main.async {
            self.newsArray = data.entries
            self.tableView.reloadData()
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
        }
    }
    
    func didFailToParseData(error: String) {
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
        }
    }
    
    func RequestDidFail(error: String) {
        DispatchQueue.main.async {
            self.showMessage(error, type: .error)
            self.stopLoadingAnimation()
            self.refreshControl.endRefreshing()
        }
    }
    
    
}
