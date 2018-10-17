//
//  Request.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

import Alamofire

protocol RequestDelegate: class {
    func didFinishRequest(data: Data?, error: Error?, endPoint: EndPoint)
}

class Request {
    
    weak var delegate: RequestDelegate?
    
    func beginGetRequest(url: URL, endPoint: EndPoint) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFinishRequest(data: nil, error: error, endPoint: endPoint)
            }
            guard let data = data else { return }
            self.delegate?.didFinishRequest(data: data, error: nil, endPoint: endPoint)
            }.resume()
    }
    
    func beginPostRequest(url: URL, parameters: [String:Any], endPoint: EndPoint) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": API.apiKey
        ]
        let params: Parameters = parameters
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response) in
            if response.error != nil {
                print(response.error!)
                self.delegate?.didFinishRequest(data: nil, error: response.error, endPoint: endPoint)
            } else {
                guard let data = response.data else { return }
                self.delegate?.didFinishRequest(data: data, error: nil, endPoint: endPoint)
            }
        }
    }

}
