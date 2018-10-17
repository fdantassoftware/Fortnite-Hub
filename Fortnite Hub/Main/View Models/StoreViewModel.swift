//
//  StoreViewModel.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 16/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol StoreProtocol: class {
    func didGetValidData(data: StoreResults)
    func didFailToParseData(error: String)
    func RequestDidFail(error: String)
}


class StoreViewModel {
    
    
    var request =  Request()
    weak var delegate: StoreProtocol?
    init() {
        request.delegate = self
    }
    
    func fetchStoreItems(endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        self.request.beginPostRequest(url: url, parameters: ["language":"en"], endPoint: endPoint)
    }
  
}

extension StoreViewModel: RequestDelegate {
    
    func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(StoreResults.self, from: data)
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
