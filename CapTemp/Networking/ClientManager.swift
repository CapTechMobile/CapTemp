//
//  ClientManager.swift
//  CapTemp
//
//  Created by Alan Shih on 9/26/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation
import Moya

struct ClientManager: NetworkClient {
    
    var provider = MoyaProvider<DarkSky>()
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping(Result)) {
        provider.request(.weather(latitude: latitude, longitude: longitude)) { result in
            switch result {
                case let .success(response):
                    do{
                        let weather = try response.map(Weather.self)
                        completion(weather, "")
                    } catch let error{
                        completion(nil, error.localizedDescription)
                    }
                case let .failure(error):
                    completion(nil, error.localizedDescription)
            }
        }
    }
}
