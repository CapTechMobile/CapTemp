//
//  Location.swift
//  CapAir
//
//  Created by Alan Shih on 10/1/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation

typealias Coordinate = (Double, Double)

struct Location {
    var name : String
    var coordinate : Coordinate
    var weather : Weather?
    
    init(name : String, coordinate : Coordinate) {
        self.name = name
        self.coordinate = coordinate
    }
}

