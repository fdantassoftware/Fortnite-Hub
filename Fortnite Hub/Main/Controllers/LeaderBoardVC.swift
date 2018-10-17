//
//  LeaderBoardVC.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import UIKit

class LeaderBoardVC: UIViewController {
    private var  leaderBoardviewModel = LeaderBoardViewModel()
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    private var leaders = [Leaderboard]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        leaderBoardviewModel.delegate = self
        self.startLoadingAnimation(loadingMessage: nil)
        fetchLeaderBoard()
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshLeaderBoard(_:)), for: .valueChanged)
    }
    
    @objc private func refreshLeaderBoard(_ sender: Any) {
        // Fetch Movies
        fetchLeaderBoard()
    }
    
    func fetchLeaderBoard() {
        leaderBoardviewModel.getLeaderBoard(endPoint: .leaderBoard())
    }
    

}

extension LeaderBoardVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as? LeaderBoardCell {
            let leader = leaders[indexPath.row]
            cell.configurecell(leader: leader, index: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaders.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}


extension LeaderBoardVC: LeaderBoardProtocol {
    
    func didGetValidData(data: LeaderBoardResult) {
        DispatchQueue.main.async {
            self.leaders = data.entries
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.stopLoadingAnimation()
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
