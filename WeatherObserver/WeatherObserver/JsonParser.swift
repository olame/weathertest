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
    
    func getParsed(data: [String : AnyObject], completion: () -> Void) -> [City : WeatherInfo]? {
        var result = [City: WeatherInfo]()
        
        if let data = data["list"] as? NSArray {
            for cityData in data {
                guard let id = cityData[FirstLevelNames.Id.rawValue] as? Int else {
                    completion()
                    return nil
                }
                guard let weathers = cityData[FirstLevelNames.WeatherDesc.rawValue] as? NSArray else {
                    completion()
                    return nil
                }
                
                let descs: [String] = weathers.map(getWeatherDescription)
                let weatherDescription = descs.joinWithSeparator(", ")
                
                if let city = City(rawValue: id){
                    var weatherInfo = WeatherInfo(description: weatherDescription)
                    
                    if let common = cityData[FirstLevelNames.Common.rawValue] as? NSDictionary {
                        if let sr = common[CommonNames.SunRise.rawValue] as? Double  {
                            weatherInfo.sunrise = NSDate(timeIntervalSince1970: sr)
                        }
                        
                        if let ss = common[CommonNames.SunSet.rawValue] as? Double {
                            weatherInfo.sunset = NSDate(timeIntervalSince1970: ss)
                        }
                    }
                    
                    if let param = cityData[FirstLevelNames.Data.rawValue] as? NSDictionary {
                        if let pressure = param[DataNames.Pressure.rawValue] as? Double {
                            weatherInfo.pressure = pressure
                        }
                        
                        if let temperature = param[DataNames.Temperature.rawValue] as? Double {
                            weatherInfo.temperature = temperature
                        }
                    }
                    result[city] = weatherInfo
               }
            }
        }
        completion()
        return result
    }
}