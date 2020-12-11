//
//  FakeResponseDataTranslation.swift
//  LeBaluchonTests
//
//  Created by Fabrice Ortega on 09/12/2020.
//

import Foundation

class FakeResponseDataTranslation {
    // Simulate answers
    static let responseOK = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/latest")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // Simulate error
    class APIError: Error{}
    static let error = APIError()
    
    //Simulate correct datas
    static var APICorrectData: Data {
        let bundle = Bundle(for: FakeResponseDataTranslation.self)
        let url = bundle.url(forResource: "TranslationJSON", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //Simule des datas endomagés
    static let APIIncorrectData = "error".data(using: .utf8)!
    
}
