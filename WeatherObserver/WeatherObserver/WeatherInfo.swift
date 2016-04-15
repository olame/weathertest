//
//  WeatherInfo.swift
//  weathertest
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import Foundation
class WeatherInfo {
    
    var description: String
    var sunrise: NSDate?
    var sunset: NSDate?
    var main: String?
    var temperature: Double?
    var pressure: Double?
    
    
    init(description: String){
        self.description = description
    }
    
}

