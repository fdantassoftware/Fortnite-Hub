//
//  StoreVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class StoreVC: UIViewController {

    private var storeItems = [Items]()
    private let refreshControl = UIRefreshControl()
    private var storeViewmodel = StoreViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        storeViewmodel.delegate = self
        self.startLoadingAnimation(loadingMessage: nil)
        fetchStoreItems()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshStore(_:)), for: .valueChanged)
    }
    
    @objc private func refreshStore(_ sender: Any) {
        // Fetch Store
        fetchStoreItems()
    }
    
    
    func fetchStoreItems() {
        storeViewmodel.fetchStoreItems(endPoint: .store())
    }
 

}

extension StoreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as? StoreCell {
            let item = storeItems[indexPath.row]
            cell.configureCell(items: item, index: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 129
    }
}


extension StoreVC: StoreProtocol {
    
    func didGetValidData(data: StoreResults) {
        DispatchQueue.main.async {
            self.storeItems = data.items
            self.stopLoadingAnimation()
            self.tableView.reloadData()
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
