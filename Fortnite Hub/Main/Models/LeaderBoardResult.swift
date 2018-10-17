//
//  LeaderBoardResult.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class LeaderBoardResult: Decodable {
    var window: String!
    var entries: [Leaderboard]!
}
