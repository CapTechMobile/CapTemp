//
//  DarkSky.swift
//  CapTemp
//
//  Created by Alan Shih on 9/25/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation
import Moya

public enum DarkSky: TargetType {
    
    //Insert Secret Key from https://darksky.net/dev
    static private let secretKey = "INSERT SECRET KEY HERE"
    
    case weather(latitude: Double, longitude: Double)
    
    public var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    public var path: String{
        switch self {
        case .weather(let latitude, let longitude):
            return "/forecast/\(DarkSky.secretKey)/\(latitude),\(longitude)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .weather:
            return .requestParameters(parameters: ["exclude":"minutely,flags,alerts,hourly"], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
