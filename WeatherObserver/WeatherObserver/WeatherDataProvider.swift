//
//  WeatherDataProvider.swift
//  weathertest
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//
// api_key = a8a454dfecd9343f3398acafa692a1a3
// ex:  http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric


import Foundation

protocol WeatherDataProviderProtocol {
    
    func getCurrentWeather(cityId: [City], completion: (data: [String: AnyObject]?, status: StatusCode) -> Void)
}

class WeatherDataProvider : WeatherDataProviderProtocol {
    private func getUrl(cityIds: [City])-> NSURL?{
        let cities = cityIds.map{return String($0.rawValue)}.joinWithSeparator(",")
        
        let components = NSURLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/group"
        
        let qI = NSURLQueryItem(name: "id", value: cities)
        let qII = NSURLQueryItem(name: "units", value: "metric")
        let qIII = NSURLQueryItem(name: "APPID", value: "a8a454dfecd9343f3398acafa692a1a3")

        components.queryItems = [qI, qII, qIII]
        return components.URL
    }
    
    func getCurrentWeather(cityIds: [City], completion: (data: [String: AnyObject]?, status: StatusCode) -> Void) {
        if let relativeURL = getUrl(cityIds) {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(relativeURL) {
                data, response, error in
                
                if let error = error?.code {
                    switch error {
                    case NSURLError.NotConnectedToInternet.rawValue, NSURLError.TimedOut.rawValue:
                        completion(data: nil, status: StatusCode.NoInternet)
                        break
                    default: break
                    }
                    if let status = StatusCode(rawValue: error) {
                        completion(data: nil, status: status)
                    }
                    else {completion(data: nil, status: StatusCode.UnknownErorr)}
                    return
                }
                
                guard let data = data else {
                    completion(data: nil, status: StatusCode.NoData)
                    return
                }
                
                guard let response = response as? NSHTTPURLResponse else {
                    completion(data: nil, status: StatusCode.BadData)
                    return
                }
                
                let code = response.statusCode
                if let data = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject]{
                    
                    print(data)
                    completion(data: data, status: StatusCode(rawValue: code)!)
                }
                else {
                    completion(data: nil, status: StatusCode.BadData)
                }
            }
            
            task.resume()
        }
    }
}


    
