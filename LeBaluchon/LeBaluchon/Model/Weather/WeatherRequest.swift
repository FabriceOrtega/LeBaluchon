//
//  WeatherRequest.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import Foundation

struct WeatherRequest {
    let headers = [
      "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
      "x-rapidapi-key": "3b9f34e4f1mshdf323313b63b2edp189e43jsn58405aaa549f"
    ]
    
    var location: String! = "City"
    
    var request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/forecast?q=london")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
    // Session
    var session = URLSession.shared
    
    init(session: URLSession) {
        self.session = session
    }
    
    
    mutating func getWeatherRequest(city:String, completion: @escaping(Result<WeatherAPI, WeatherRequestError>) -> Void){
        
        // Transform the string to remve the space
        let transfomedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        // Include the city in the request
        request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/forecast?q=\(transfomedCity)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Create the task
        
        let dataTask = session.dataTask(with: request as URLRequest){data, response, error in
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
                let weatherResponse = try decoder.decode(WeatherAPI.self, from: jsonData)
                print("testSuccess: \(weatherResponse)")
                
                completion(.success(weatherResponse))
                
                // If not ptossible to decode
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

enum WeatherRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
