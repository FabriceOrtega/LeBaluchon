//
//  CurrencyTestCase.swift
//  LeBaluchonTests
//
//  Created by Fabrice Ortega on 09/12/2020.
//

import XCTest
@testable import LeBaluchon

class CurrencyTestCase: XCTestCase {
    
    // Test the convertion from Euro to another currency
    func testGivenFiveEurosAndRateIsOnePointTwoWhenChangingToOtherCurrencyThenResultShouldBeSix() {
        Currency.currency.originAmount = 5
        Currency.currency.rate = 1.2
        
        Currency.currency.calculateOriginToDestination()
        
        XCTAssert(Currency.currency.destinationAmount == 6)
    }
    
    // Test the convertion from Euro to another currency
    func testGivenThreeOtherCurrencyAndRateIsOnePointTwoWhenChangingToOtherEuroThenResultShouldBeTwoPointFive() {
        Currency.currency.destinationAmount = 3
        Currency.currency.rate = 1.2
        
        Currency.currency.calculateDestinationToOrigin()
        
        XCTAssert(Currency.currency.originAmount == 2.5)
    }
}
