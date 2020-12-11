//
//  WeatherAPI.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct WeatherAPI: Decodable, Equatable {
    var list: [List]
    var city: City
}
