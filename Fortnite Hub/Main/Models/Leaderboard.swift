//
//  Leaderboard.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Leaderboard: Decodable {
    var username: String!
    var kills: String!
    var wins: String!
    var score: String!
    var platform: String!
}
