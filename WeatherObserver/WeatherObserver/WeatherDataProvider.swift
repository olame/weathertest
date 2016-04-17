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
    
    private let baseUrl = "http://api.openweathermap.org/data/2.5/group?id=%@&units=metric&APPID=a8a454dfecd9343f3398acafa692a1a3"
    private let session: NSURLSession?
    
    init(){
        
        self.session = NSURLSession.sharedSession()
    }
    
    
    func getCurrentWeather(cityIds: [City], completion: (data: [String: AnyObject]?, status: StatusCode) -> Void) {
        
        let cities = cityIds.map{return String($0.rawValue)}.joinWithSeparator(",")
        
        
        let relativeURLString = String(format: baseUrl, cities)
        let relativeURL = NSURL(string: relativeURLString)
        
        
        let task = session!.dataTaskWithURL(relativeURL!) {
            d, r, e in
            
            if let error = e?.code {
                
                if let status = StatusCode(rawValue: error) {
                    completion(data: nil, status: status)
                }
                else {completion(data: nil, status: StatusCode.UnknownErorr)}
                return
            }
            
            guard let data = d else {
                completion(data: nil, status: StatusCode.NoData)
                return
            }
            
            
            guard let response = r as? NSHTTPURLResponse else {
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


    
