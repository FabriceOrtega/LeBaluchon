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
      "x-rapidapi-key": ""
    ]
    
    var location: String = "City"
    
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
            
            
            // If data available, convert it thru the decoder
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherAPI.self, from: jsonData)
                
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
