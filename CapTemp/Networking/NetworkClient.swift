//
//  Networkable.swift
//  CapTemp
//
//  Created by Alan Shih on 9/26/18.
//  Copyright © 2018 CapTech. All rights reserved.
//
import Moya

protocol NetworkClient {
    typealias Success = NSError
    typealias Result = (Weather?, String) -> ()
    
    var provider: MoyaProvider<DarkSky> { get }
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping(Result))
}
