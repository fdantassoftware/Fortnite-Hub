//
//  PlayerDataViewModel.swift
//  Fortnite Hub
//
//  Created by Fabio Dantas on 11/10/2018.
//  Copyright © 2018 Fabio Dantas. All rights reserved.
//

import Foundation

protocol PlayerDataProtocol: class {
    func didGetValidData(Playerdata: PlayerData, modeData: [Mode])
    func didFailToParseData(error: String)
    func RequestDidFail(error: String)
}

class PlayerDataViewModel {
   
    private var platform = ""
    var request =  Request()
    weak var delegate: PlayerDataProtocol?
    init() {
        request.delegate = self
    }
    
    var userID: String? {
        didSet {
            getUserData(userId: self.userID!, platform: self.platform, endPoint: .playerData())
        }
    }
    
    func getUserData(userId: String, platform: String, endPoint: EndPoint) {
        guard let url = endPoint.url else {return}
        self.request.beginPostRequest(url: url, parameters: ["user_id":userId, "platform":platform, "window":"alltime"], endPoint: endPoint)
    }
    
    func getUserID(id: String?, platform: String, endPoint: EndPoint) {
        self.platform = platform
        if id != nil {
            guard let url = endPoint.url else {return}
            self.request.beginPostRequest(url: url, parameters: ["username":id!], endPoint: endPoint)
        } else {
            // Handle Error
        }
    }
    
    
    func setModesData(data: PlayerData) {
        let solo = Mode()
        let duo = Mode()
        let squad = Mode()
        solo.wins = data.stats!.placetop1_solo
        solo.matchesPlayed = data.stats!.matchesplayed_solo!
        solo.winRate = data.stats!.winrate_solo!
        solo.timePlayed = data.stats!.minutesplayed_solo!
        solo.kills = data.stats!.kills_solo!
        solo.kdRatio = data.stats!.kd_solo!
        solo.score = data.stats!.score_solo!
        solo.lastUpdate = data.stats!.lastmodified_solo!
        
        duo.wins = data.stats!.placetop1_duo
        duo.matchesPlayed = data.stats!.matchesplayed_duo!
        duo.winRate = data.stats!.winrate_duo!
        duo.timePlayed = data.stats!.minutesplayed_duo!
        duo.kills = data.stats!.kills_duo!
        duo.kdRatio = data.stats!.kd_duo!
        duo.score = data.stats!.score_duo!
        duo.lastUpdate = data.stats!.lastmodified_duo!
        
        squad.wins = data.stats!.placetop1_squad
        squad.matchesPlayed = data.stats!.matchesplayed_squad!
        squad.winRate = data.stats!.winrate_squad!
        squad.timePlayed = data.stats!.minutesplayed_squad!
        squad.kills = data.stats!.kills_squad!
        squad.kdRatio = data.stats!.kd_squad!
        squad.score = data.stats!.score_squad!
        squad.lastUpdate = data.stats!.lastmodified_squad!
        
        let modes = [solo, duo, squad]
        self.delegate?.didGetValidData(Playerdata: data, modeData: modes)
    }
    
    
    func parseData(data: Data, endPoint: EndPoint) {
        
        switch endPoint {
        case .userID():
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                if parsedData["numericErrorCode"] != nil {
                    self.delegate?.RequestDidFail(error: "Username not found.")
                    
                } else {
                    let result = try JSONDecoder().decode(PlayerID.self, from: data)
                    guard let id = result.uid else {return}
                     userID = id
                }
            } catch {
                self.delegate?.RequestDidFail(error: "Username not found.")
            }

        case .playerData():
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                if parsedData["numericErrorCode"] != nil {
                    self.delegate?.RequestDidFail(error: "Username not found.")
                } else {
                    let result = try JSONDecoder().decode(PlayerData.self, from: data)
                    setModesData(data: result)
                }
                
            } catch let error {
                print(error)
                self.delegate?.didFailToParseData(error: "An error has ocurred. Try again Later")
            }
        default:
            break
        }
    }
}

extension PlayerDataViewModel: RequestDelegate {
    
    func didFinishRequest(data: Data?, error: Error?, endPoint: EndPoint) {
        if error != nil {
            // handle error
            self.delegate?.RequestDidFail(error: "Error while connection to server.")
        }
        
        if data != nil {
            // valid data
            switch endPoint {
            case .playerData():
                print("Player Data")
                parseData(data: data!, endPoint: endPoint)
            case .userID():
                parseData(data: data!, endPoint: endPoint)
            default:
                break
            }
        } else {
            // Error data invalid
            self.delegate?.RequestDidFail(error: "Error while connection to server.")
        }
    }
}
