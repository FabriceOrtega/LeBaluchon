//
//  List.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct List: Decodable, Equatable {
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var visibility: Int
    var dt_txt: String
}
