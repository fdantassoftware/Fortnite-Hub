//
//  Stats.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Stats: Decodable {
    
    var kills_solo: Int?
    var matchesplayed_solo: Int?
    var kd_solo: Double?
    var winrate_solo: Double?
    var score_solo: Int?
    var minutesplayed_solo: Int?
    var lastmodified_solo: Int?
    var kills_duo: Int?
    var matchesplayed_duo: Int?
    var kd_duo: Double?
    var winrate_duo: Double?
    var score_duo: Int?
    var minutesplayed_duo: Int?
    var lastmodified_duo: Int?
    var kills_squad: Int?
    var matchesplayed_squad: Int?
    var kd_squad: Double?
    var winrate_squad: Double?
    var score_squad: Int?
    var minutesplayed_squad: Int?
    var lastmodified_squad: Int?
    var placetop1_solo: Int?
    var placetop1_duo: Int?
    var placetop1_squad: Int?
}
