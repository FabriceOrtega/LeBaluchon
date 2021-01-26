//
//  Currency.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import Foundation

class Currency {
    // Pattern singleton
    public static let currency = Currency()
    
    // Rates between the two currencies
    var rate: Double?
    
    // Origin amount
    var originAmount: Double?
    
    // Destination amount
    var destinationAmount: Double?
    
    // Public init for pattern singleton
    public init() {}
    
    func calculateOriginToDestination() {
        if originAmount != nil {
            if let rate = rate,  let originAmount = originAmount {
                destinationAmount = round(100 * originAmount * rate) / 100
            }
        }
    }
    
    func calculateDestinationToOrigin() {
        if destinationAmount != nil {
            if let rate = rate, let destinationAmount = destinationAmount {
                originAmount = round(100 * destinationAmount / rate) / 100
            }
        }
    }
}
