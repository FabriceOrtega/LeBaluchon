//
//  TranslationRequest.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct TranslationRequest {
    // create the request body
    var requestBody = "q=Salut&source=fr&target=en&format=text"
    
    //API key
    let apiKeyTranslation = "AIzaSyAMLie8Ab6iLztG1vnXDVVhN1TjzVRgE5o"
    
    var url = URL(string: "https://translation.googleapis.com/language/translate/v2")
    
    var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    mutating func getRequest(text:String, completion: @escaping(Result<TranslateAPI, TranslationError>) -> Void) {
        // Include the api key in the request
        url = URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(apiKeyTranslation)")
        
        // Updtate the body according user's data
        requestBody = "q=\(text)&source=\(Parameters.parameters.originLanguage)&target=\(Parameters.parameters.destinationLanguage)&format=text"
        
        // Configure the request with POST method and body
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // insert json data to the request
        let jsonBodyData = requestBody.data(using: String.Encoding.utf8)
        request.httpBody = jsonBodyData
        
        // Create the task
        let dataTask = session.dataTask(with: request) {data, response, error in
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
                let translationResponse = try decoder.decode(TranslateAPI.self, from: jsonData)
                print("test: \(translationResponse)")
                
                completion(.success(translationResponse))
                
                // If not ptossible to decode
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}

// Enumeration in order to be get more precise errprs
enum TranslationError: Error {
    case noDataAvailable
    case canNotProcessData
}
