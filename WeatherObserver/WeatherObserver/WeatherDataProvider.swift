//
//  WeatherDataProvider.swift
//  weathertest
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import Foundation

protocol WeatherDataProviderProtocol {
    func getCities() -> [String]
    func getCurrentWeather(cityId: Int) -> WeatherInfo
}

class WeatherDataProvider : WeatherDataProviderProtocol {
    
    let session: NSURLSession?
    
    init(){
        
        self.session = NSURLSession.sharedSession()
    }
    
    func getCities() -> [String] {
        return [String]()
    }
    
    func getCurrentWeather(cityId: Int) -> WeatherInfo {
        return WeatherInfo()
    }
}


    
