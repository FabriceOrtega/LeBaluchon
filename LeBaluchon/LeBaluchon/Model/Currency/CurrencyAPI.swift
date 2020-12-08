//
//  CurrencyAPI.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import Foundation

struct CurrencyAPI: Decodable, Equatable {
    var success: Bool
    var timestamp: Int
    var base: String
    var date: String
    var rates: Rates
}
