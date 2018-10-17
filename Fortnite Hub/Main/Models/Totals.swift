//
//  Totals.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class Totals: Decodable {
    
    var kills: Int?
    var wins: Int?
    var matchesplayed: Int?
    var minutesplayed: Int?
    var hoursplayed: Int?
    var score: Int?
    var winrate: Double?
    var kd: Double?
    var lastupdate: Int?
}
