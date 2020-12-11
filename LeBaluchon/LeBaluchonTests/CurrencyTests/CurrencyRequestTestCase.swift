//
//  CurrencyRequestTestCase.swift
//  LeBaluchonTests
//
//  Created by Fabrice Ortega on 09/12/2020.
//

import XCTest
@testable import LeBaluchon

class CurrencyRequestTestCase: XCTestCase {
    
    func testGetAPIShouldPostAnErrorifError(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataCurrency.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let currency):
                XCTAssertNil(currency)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifNoData(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let currency):
                XCTAssertNil(currency)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectResponse(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: FakeResponseDataCurrency.APICorrectData, response: FakeResponseDataCurrency.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let currency):
                XCTAssertNotNil(currency)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldNotPostAnErrorifCorrectResponse(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: FakeResponseDataCurrency.APICorrectData, response: FakeResponseDataCurrency.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let currency):
                XCTAssertNotNil(currency)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectData(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: FakeResponseDataCurrency.APIIncorrectData, response: FakeResponseDataCurrency.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let currency):
                XCTAssertNotNil(currency)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldBeSuccessfullWhenAllIsCorrect(){
        var myAPI = CurrencyRequest(session: URLSessionFake(data: FakeResponseDataCurrency.APICorrectData, response: FakeResponseDataCurrency.responseOK, error: nil))
        
        // Build the expected result
        let currencyList = LeBaluchon.CurrencyAPI(success: true, timestamp: 1607504045, base: "EUR", date: "2020-12-09", rates: LeBaluchon.Rates(AED: 4.456488, AFN: 93.221345, ALL: 124.052871, AMD: 623.803823, ANG: 2.177212, AOA: 792.989201, ARS: 98.986637, AUD: 1.625519, AWG: 2.183976, AZN: 2.061391, BAM: 1.95935, BBD: 2.449, BDT: 102.85118, BGN: 1.955264, BHD: 0.457471, BIF: 2350.465982, BMD: 1.21332, BND: 1.622634, BOB: 8.338982, BRL: 6.213163, BSD: 1.212979, BTC: 6.7892339e-05, BTN: 89.279133, BWP: 13.299794, BYN: 3.102774, BYR: 23781.068571, BZD: 2.444892, CAD: 1.551029, CDF: 2390.240276, CHF: 1.07693, CLF: 0.032755, CLP: 903.808505, CNY: 7.939929, COP: 4235.092849, CRC: 729.404188, CUC: 1.21332, CUP: 32.152975, CVE: 110.464368, CZK: 26.245324, DJF: 215.93795, DKK: 7.443535, DOP: 70.568568, DZD: 158.720806, EGP: 19.012654, ERN: 18.199664, ETB: 46.570207, EUR: 1.0, FJD: 2.498709, FKP: 0.904149, GBP: 0.903966, GEL: 3.980137, GGP: 0.904149, GHS: 7.107929, GIP: 0.904149, GMD: 62.789056, GNF: 12004.188804, GTQ: 9.479208, GYD: 253.768006, HKD: 9.405773, HNL: 29.339633, HRK: 7.542236, HTG: 84.278827, HUF: 357.649854, IDR: 17095.069675, ILS: 3.947476, IMP: 0.904149, INR: 89.271345, IQD: 1448.021485, IRR: 51086.830848, ISK: 153.109417, JEP: 0.904149, JMD: 174.517535, JOD: 0.859394, JPY: 126.418195, KES: 135.333786, KGS: 102.892258, KHR: 4953.341752, KMF: 493.323263, KPW: 1092.018238, KRW: 1316.779418, KWD: 0.369881, KYD: 1.010716, KZT: 509.906087, LAK: 11251.213695, LBP: 1833.994917, LKR: 225.970574, LRD: 194.55534, LSL: 18.290755, LTL: 3.582618, LVL: 0.733925, LYD: 1.631631, MAD: 10.912405, MDL: 21.014154, MGA: 4795.014623, MKD: 61.574392, MMK: 1615.635016, MNT: 3461.809073, MOP: 9.683297, MRO: 433.155802, MUR: 47.986818, MVR: 18.757738, MWK: 918.8017, MXN: 23.935464, MYR: 4.930921, MZN: 90.240634, NAD: 18.211869, NGN: 462.577643, NIO: 42.263615, NOK: 10.556611, NPR: 142.82087, NZD: 1.714433, OMR: 0.466539, PAB: 1.212879, PEN: 4.370853, PGK: 4.267328, PHP: 58.318818, PKR: 194.494825, PLN: 4.438069, PYG: 8530.024864, QAR: 4.417723, RON: 4.870018, RSD: 117.571358, RUB: 88.841095, RWF: 1200.276391, SAR: 4.551749, SBD: 9.788816, SCR: 25.729857, SDG: 67.098876, SEK: 10.256673, SGD: 1.621432, SHP: 0.904149, SLL: 12303.062786, SOS: 707.365499, SRD: 17.17333, STD: 25518.428528, SVC: 10.613067, SYP: 622.202756, SZL: 18.298976, THB: 36.477268, TJS: 13.739698, TMT: 4.246619, TND: 3.280774, TOP: 2.776258, TRY: 9.495168, TTD: 8.236197, TWD: 34.24777, TZS: 2812.118615, UAH: 34.05929, UGX: 4463.6561, USD: 1.21332, UYU: 51.726357, UZS: 12666.806921, VEF: 12.118029, VND: 28062.874233, VUV: 134.503151, WST: 3.090636, XAF: 657.1376, XAG: 0.049785, XAU: 0.000651, XCD: 3.279057, XDR: 0.845419, XOF: 657.1376, XPF: 120.058298, YER: 303.84558, ZAR: 18.156238, ZMK: 10921.336008, ZMW: 25.520249, ZWL: 390.688912))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let currency):
                XCTAssertNotNil(currency)
                XCTAssertEqual(currency, currencyList)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}


