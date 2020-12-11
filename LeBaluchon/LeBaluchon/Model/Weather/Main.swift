//
//  Main.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct Main: Decodable, Equatable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    
    //Concert temp in celcius
    var calcultedCelciusTemp: Double {temp - 273.15}
    }
