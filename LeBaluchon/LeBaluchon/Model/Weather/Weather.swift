//
//  Weather.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct Weather: Decodable, Equatable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
