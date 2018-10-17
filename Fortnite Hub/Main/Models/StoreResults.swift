//
//  StoreResults.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation
import UIKit

class StoreResults: Decodable {
    
    var date: String!
    var items: [Items]!
}

class Items: Decodable {
    var name: String!
    var cost: String!
    var item: Item!
}

class Item: Decodable {
    
    var image: String!
    var type: String!
    var rarity: String!
    var obtained_type: String!
}

