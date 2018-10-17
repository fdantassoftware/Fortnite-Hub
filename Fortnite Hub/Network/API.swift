//
//  API.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

class API {
    
    // We could store the api key more securely however for simplicity lets put it here
    static let apiKey = "89a788b869eca1893d4a6a713e07dfeb"
}



enum EndPoint {
    // If we need to add another endpoint we just need to create a new case and pass however we need to the enum ex page, language etc
    case playerData()
    case userID()
    case leaderBoard()
    case news()
    case store()
    private var baseURL: String {
        let url = "fortnite-public-api.theapinetwork.com"
        return url
        
    }
    
    // here we build our url easily using URLComponents according to the end point we want
    var url: URL? {
        switch self {
        case .playerData:
            var url = URLComponents()
            url.scheme = "https"
            url.host = baseURL
            url.path = "/prod09/users/public/br_stats"
            return url.url
        case .userID:
            var url = URLComponents()
            url.scheme = "https"
            url.host = baseURL
            url.path = "/prod09/users/id"
            return url.url
        case .leaderBoard():
            var url = URLComponents()
            url.scheme = "https"
            url.host = baseURL
            url.path = "/prod09/leaderboards/get"
            return url.url
        case .news():
            var url = URLComponents()
            url.scheme = "https"
            url.host = baseURL
            url.path = "/prod09/br_motd/get"
            return url.url
        case .store():
            var url = URLComponents()
            url.scheme = "https"
            url.host = baseURL
            url.path = "/prod09/store/get"
            return url.url
        }
    }
    
}


