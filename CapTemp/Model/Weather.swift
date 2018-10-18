//
//  Weather.swift
//  CapTemp
//
//  Created by Alan Shih on 9/26/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation

struct Weather {
    let timezone : String
    let current: Forecast
    let summary : String
    let forecast : [Forecast]
}

extension Weather: Decodable {
    
    enum RootKeys: String, CodingKey{
        case timezone, currently, daily
    }
    enum DailyKeys: String, CodingKey {
        case summary, icon, data
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        timezone = try rootContainer.decode(String.self, forKey: .timezone)

        let dailyContainer = try rootContainer.nestedContainer(keyedBy: DailyKeys.self, forKey: .daily)
        
        current = try rootContainer.decode(Forecast.self, forKey: .currently)
        forecast = try dailyContainer.decode([Forecast].self, forKey: .data)
        summary = try dailyContainer.decode(String.self, forKey: .summary)
        
    }
}

