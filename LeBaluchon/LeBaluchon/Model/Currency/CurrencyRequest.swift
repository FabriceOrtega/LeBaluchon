//
//  CurrencyRequest.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import Foundation

struct CurrencyRequest {
    // Build URL with the key and the currency !! Only EUR as base is working as i subscribed to free account
    let apiKey = "9d8a78de63e9400f6cfa79ad1c98ef3f"
    let baseCurrency = Parameters.parameters.originCurrency
    
    var url = URL(string: "http://data.fixer.io/api/latest")
    
    var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    mutating func getRequest(completion: @escaping(Result<CurrencyAPI, CurrencyError>) -> Void) {
        // Update URL with the key and currency
        url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=\(baseCurrency)&format=1")
        
        // Create the task
        let dataTask = session.dataTask(with: url!) {data, response, error in
            // check if data is available
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            // Print the data
            if let data = data, let stringResponse = String(data: data, encoding: .utf8) {
                            print("Response \(stringResponse)")
                        }
            
            // If data available, convert it thru the decoder
            do {
                let decoder = JSONDecoder()
                let currencyResponse = try decoder.decode(CurrencyAPI.self, from: jsonData)
                print("test: \(currencyResponse)")
                
                completion(.success(currencyResponse))
                
                // If not ptossible to decode
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}

// Enumeration in order to be get more precise errprs
enum CurrencyError: Error {
    case noDataAvailable
    case canNotProcessData
}
