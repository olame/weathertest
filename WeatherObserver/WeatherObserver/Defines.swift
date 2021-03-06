//
//  Defines.swift
//  weathertest
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import Foundation
enum UIMessages: String {
    case NoInternetConnection = "It seems no internet connection on device. Try later."
    case BadRequest = "Http error: server does not answer, the bad request was sent."
    case NotFound = "Http error: server was not found."
    case UnknownError = "Unknown error during network communication. Try again."
    case NoData = "No data from server response"
}

enum City : Int {
    case Moscow = 524901
    case SaintPetersburg = 498817
    case RespublikaKareliya = 552548
    case Chelyabinsk = 1508291
    case NizhniyNovgorod = 520555
    case Astrakhan = 580497
    case Tver = 480060
    case Cherepovets = 569223
    case Izhevsk = 554840
    case Nakhodka = 2019528
    case Taganrog = 484907
    

    func name() -> String {
        let names: [City:String] = [.Moscow: "Moscow", .SaintPetersburg: "Saint Petersburg", .Astrakhan: "Astrakhan", .Chelyabinsk: "Chelyabinsk", .Cherepovets: "Cherepovets", .Tver: "Tver", .RespublikaKareliya: "Respublika Kareliya", .Izhevsk: "Izhevsk", .Nakhodka: "Nakhodka", .NizhniyNovgorod: "Nizhniy Novgorod", .Taganrog: "Taganrog"]
        return names[self] ?? ""
    }
}

enum StatusCode: Int {
    case Success = 200
    case BadRequest = 400
    case NotFound = 404
    case UnknownErorr = 1000
    case NoData = 1001
    case BadData = 1002
    case NoInternet = 1003
}

enum FirstLevelNames: String {
    case Id = "id"
    case Name = "name"
    case Clouds = "clouds"
    case Coordinates = "coord"
    case Data = "main"
    case Common = "sys"
    case WeatherDesc = "weather"
    case Wind = "wind"
    case Rain = "rain"
}

enum DataNames : String {
    case Humidity = "humidity"
    case Pressure = "pressure"
    case Temperature = "temp"
    case MaxTemperature = "temp_max"
    case MinTemperature = "temp_min"
}

enum CommonNames : String {
    case Country = "country"
    case SunRise = "sunrise"
    case SunSet = "sunset"
}


enum WeatherNames : String {
    case Description = "description"
    case Main = "main"
}

enum WindNames : String {
    case Degree = "deg"
    case Speed = "speed"
}

enum CloudsNames : String {
    case All = "all"
}
