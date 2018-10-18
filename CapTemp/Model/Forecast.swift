//
//  Forecast.swift
//  CapAir
//
//  Created by Alan Shih on 9/27/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation

struct Forecast {
    let summary: String
    let icon: WeatherCondition
    let sunriseTime: Int
    let sunsetTime: Int
    var sunriseDateString: String {
        return DateUtil.formattedDate(timeInSeconds: self.sunriseTime)
    }
    var sunsetDateString: String {
        return DateUtil.formattedDate(timeInSeconds: self.sunsetTime)
    }
    let precipProbability: Double
    let precipType: PrecipitationType
    let temperature: Double
    let temperatureHigh: Double
    let temperatureLow: Double
    let humidity: Double
    let windSpeed: Double
    let uvIndex: Int
}

extension Forecast: Decodable {
    
    enum ForecastKeys : String, CodingKey {
        case summary, icon, sunriseTime, sunsetTime, precipProbability, precipType, temperature, temperatureHigh, temperatureLow, humidity, windSpeed, uvIndex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ForecastKeys.self)
        
        //Required Fields
        summary = try container.decode(String.self, forKey: .summary)
        icon = WeatherCondition(rawValue: try container.decode(String.self, forKey: .icon)) ?? .unknown
        precipProbability = try container.decode(Double.self, forKey: .precipProbability)
        humidity = try container.decode(Double.self, forKey: .humidity)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        uvIndex = try container.decode(Int.self, forKey: .uvIndex)
        
        //Optional Fields
        sunsetTime = container.contains(.sunsetTime) ? try container.decode(Int.self, forKey: .sunsetTime) : 0
        sunriseTime = container.contains(.sunsetTime) ? try container.decode(Int.self, forKey: .sunriseTime) : 0
        precipType = container.contains(.precipType) ? PrecipitationType(rawValue: try container.decode(String.self, forKey: .precipType)) ?? .rain : .rain
        temperature = container.contains(.temperature) ? try container.decode(Double.self, forKey: .temperature) : 0
        temperatureHigh = container.contains(.temperatureHigh) ? try container.decode(Double.self, forKey: .temperatureHigh) : 0
        temperatureLow = container.contains(.temperatureLow) ? try container.decode(Double.self, forKey: .temperatureLow) : 0
        
    }
}

extension Forecast {
    func getConditionImageName() -> String{
        
        var imageName = "unknown"
        
        switch self.icon {
        case .clearDay:
            imageName = "clear"
        case .clearNight:
            imageName = "clearnight"
        case .cloudy:
            imageName = "cloudy"
        case .fog:
            imageName = "fog"
        case .partlyCloudyDay:
            imageName = "partlycloudyday"
        case .partlyCloudyNight:
            imageName = "partlycloudynight"
        case .rain:
            imageName = "rain"
        case .sleet:
            imageName = "sleet"
        case .snow:
            imageName = "snow"
        case .wind:
            imageName = "wind"
        default:
            break
        }
        
        return imageName
    }
    
    func getPercipitationTypeImage() -> String{
        
        var imageName = "water"
        
        switch self.precipType {
            case .sleet,
                 .snow:
                imageName = "snowflake"
                break
            default:
                break
        }
        
        return imageName
    }
}
