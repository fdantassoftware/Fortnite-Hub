//
//  PlayerData.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class PlayerData: Decodable {
    var username: String?
    var platform: String?
    var timestamp: Int?
    var window: String?
    var stats: Stats?
    var totals: Totals?
    
}
