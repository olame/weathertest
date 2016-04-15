//
//  Defines.swift
//  weathertest
//
//  Created by Olga Grineva on 15/04/16.
//  Copyright © 2016 Olga Grineva. All rights reserved.
//

import Foundation
enum City : Int {
    
    case Moscow = 524901
    case SaintPetersburg = 498817
    case RespublikaKareliya = 552548
    case Chelyabinsk = 150829
    case NizhniyNovgorod = 520555
    case Astrakhan = 580497
    case Tver = 480060
    case Cherepovets = 569223
    case Izhevsk = 554840
    case Nakhodka = 2019528
    case Taganrog = 484907
    
    func name() -> String {
        
        switch self {
            
        case .Moscow: return "Moscow"
        case .SaintPetersburg: return "Saint Petersburg"
        case .Astrakhan: return "Astrakhan"
        case .Chelyabinsk: return "Chelyabinsk"
        case .Cherepovets: return "Cherepovets"
        case .Tver: return "Tver"
        case .RespublikaKareliya: return "Respublika Kareliya"
        case .Izhevsk: return "Izhevsk"
        case .Nakhodka: return "Nakhodka"
        case .NizhniyNovgorod: return "Nizhniy Novgorod"
        case .Taganrog: return "Taganrog"
            
        default: return ""
        }
    }
}