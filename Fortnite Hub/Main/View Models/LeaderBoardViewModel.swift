//
//  LeaderBoardViewModel.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 15/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol LeaderBoardProtocol: class {
    func didGetValidData(data: LeaderBoardResult)
    func didFailToParseData(error: String)
    func RequestDidFail(error: String)
}

class LeaderBoardViewModel{
    
    var request =  Request()
    weak var delegate: LeaderBoardProtocol?
    init() {
        request.delegate = self
    }
    
    
    func getLeaderBoard(endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        self.request.beginPostRequest(url: url, parameters: ["window":"top_10_kills"], endPoint: endPoint)
    }
}


extension LeaderBoardViewModel: RequestDelegate {
    
    
    func parseData(data: Data) {
        do {
            let result = try JSONDecoder().decode(LeaderBoardResult.self, from: data)
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
