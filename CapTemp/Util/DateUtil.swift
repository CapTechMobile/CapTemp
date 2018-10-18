//
//  DateUtil.swift
//  CapTemp
//
//  Created by Alan Shih on 10/10/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import Foundation

class DateUtil {
    
    static func formattedDate(timeInSeconds: Int) -> String{
        if(timeInSeconds == 0){
            return "-:--"
        }
        
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeInSeconds))
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        return formatter.string(from: date)
    }
}
