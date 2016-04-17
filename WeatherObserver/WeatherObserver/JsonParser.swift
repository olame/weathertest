//
//  JsonParser.swift
//  WeatherObserver
//
//  Created by Olga Grineva on 17/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import Foundation
class JsonParser {
    
    private func getWeatherDescription(w: AnyObject) -> String {
        
        guard let weather = w as? NSDictionary,let desc = weather[WeatherNames.Description.rawValue] as? String else {return ""}
        return desc.capitalizedString
    }
    
    func getParsed(data: [String : AnyObject]) -> [City : WeatherInfo] {
        
        var result = [City: WeatherInfo]()
        
        if let list = data["list"] as? NSArray {
            
            for c in list {
                
                guard let id = c[FirstLevelNames.Id.rawValue] as? Int else { return result }
                
                guard let weathers = c[FirstLevelNames.WeatherDesc.rawValue] as? NSArray else {return result}
                
                let descs: [String] = weathers.map(getWeatherDescription)
                
                var weatherDescription = descs.joinWithSeparator(", ")
                
                
                if let city = City(rawValue: id){
                    //parsing here

                    var weatherInfo = WeatherInfo(description: weatherDescription)
                    result[city] = weatherInfo

                    if let common = c[FirstLevelNames.Common.rawValue] as? NSDictionary {
                        if let sr = common[CommonNames.SunRise.rawValue] as? Double  {
                            weatherInfo.sunrise = NSDate(timeIntervalSince1970: sr)
                        }
                        
                        if let ss = common[CommonNames.SunSet.rawValue] as? Double {
                            weatherInfo.sunset = NSDate(timeIntervalSince1970: ss)
                        }
                    }
                    
                    if let param = c[FirstLevelNames.Data.rawValue] as? NSDictionary {
                        if let pressure = param[DataNames.Pressure.rawValue] as? Double {
                            weatherInfo.pressure = pressure
                        }
                        
                        if let temperature = param[DataNames.Temperature.rawValue] as? Double {
                            weatherInfo.temperature = temperature
                        }
                    }
                
               }
            }
        }
        
        return result
        
    }
}