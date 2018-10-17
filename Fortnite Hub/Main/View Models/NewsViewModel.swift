//
//  NewsViewModel.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol NewsProtocol: class {
    func didGetValidData(data: NewsResult)
    func didFailToParseData(error: String)
    func RequestDidFail(error: String)
}

class NewsViewModel {
    
    var request =  Request()
    weak var delegate: NewsProtocol?
    init() {
        request.delegate = self
    }
    
    func fetchNews(endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        self.request.beginPostRequest(url: url, parameters: ["language":"en"], endPoint: endPoint)
    }
}


extension NewsViewModel: RequestDelegate {
    
    func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(NewsResult.self, from: data)
            self.delegate?.didGetValidData(data: result)
        } catch let error {
            print(error)
            self.delegate?.didFailToParseData(error: "An error has ocurred. Try again Later")
        }
    }
    
    
    func didFinishRequest(data: Data?, error: Error?, endPoint: EndPoint) {
        
        if error != nil {
            // handle error
            self.delegate?.RequestDidFail(error: "Error while connection to server.")
        }
        
        if data != nil {
            // valid data
            parseData(data: data!)
        } else {
            // Error data invalid
            self.delegate?.RequestDidFail(error: "Error while connection to server.")
        }
    }
    
    
}
