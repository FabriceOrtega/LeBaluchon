//
//  WeatherRequestTestCase.swift
//  LeBaluchonTests
//
//  Created by Fabrice Ortega on 09/12/2020.
//

import XCTest
@testable import LeBaluchon

class WeatherRequestTestCase: XCTestCase {
    
    func testGetAPIShouldPostAnErrorifError(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataWeather.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let weather):
                XCTAssertNil(weather)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifNoData(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let weather):
                XCTAssertNil(weather)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectResponse(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: FakeResponseDataWeather.APICorrectData, response: FakeResponseDataWeather.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let weather):
                XCTAssertNotNil(weather)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldNotPostAnErrorifCorrectResponse(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: FakeResponseDataWeather.APICorrectData, response: FakeResponseDataWeather.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let weather):
                XCTAssertNotNil(weather)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectData(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: FakeResponseDataWeather.APIIncorrectData, response: FakeResponseDataWeather.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let weather):
                XCTAssertNotNil(weather)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldBeSuccessfullWhenAllIsCorrect(){
        var myAPI = WeatherRequest(session: URLSessionFake(data: FakeResponseDataWeather.APICorrectData, response: FakeResponseDataWeather.responseOK, error: nil))
        
        // Build the expected result
        let weatherList = LeBaluchon.WeatherAPI(list: [LeBaluchon.List(main: LeBaluchon.Main(temp: 274.03, feels_like: 268.03, temp_min: 274.03, temp_max: 274.57, pressure: 1011), weather: [LeBaluchon.Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03n")], wind: LeBaluchon.Wind(speed: 5.04, deg: 255), visibility: 10000, dt_txt: "2020-12-09 12:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 275.1, feels_like: 268.31, temp_min: 275.1, temp_max: 275.54, pressure: 1010), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 6.44, deg: 257), visibility: 10000, dt_txt: "2020-12-09 15:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 274.92, feels_like: 268.43, temp_min: 274.92, temp_max: 275.02, pressure: 1008), weather: [LeBaluchon.Weather(id: 600, main: "Snow", description: "light snow", icon: "13d")], wind: LeBaluchon.Wind(speed: 6.34, deg: 259), visibility: 9411, dt_txt: "2020-12-09 18:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.26, feels_like: 269.84, temp_min: 276.26, temp_max: 276.28, pressure: 1008), weather: [LeBaluchon.Weather(id: 600, main: "Snow", description: "light snow", icon: "13d")], wind: LeBaluchon.Wind(speed: 6.26, deg: 250), visibility: 10000, dt_txt: "2020-12-09 21:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 277.1, feels_like: 271.17, temp_min: 277.1, temp_max: 277.1, pressure: 1009), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 5.58, deg: 257), visibility: 10000, dt_txt: "2020-12-10 00:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.87, feels_like: 270.36, temp_min: 276.87, temp_max: 276.87, pressure: 1009), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 6.4, deg: 281), visibility: 10000, dt_txt: "2020-12-10 03:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 277.05, feels_like: 270.64, temp_min: 277.05, temp_max: 277.05, pressure: 1010), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 6.37, deg: 286), visibility: 10000, dt_txt: "2020-12-10 06:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 277.54, feels_like: 271.63, temp_min: 277.54, temp_max: 277.54, pressure: 1012), weather: [LeBaluchon.Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03n")], wind: LeBaluchon.Wind(speed: 5.6, deg: 280), visibility: 10000, dt_txt: "2020-12-10 09:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.74, feels_like: 271.17, temp_min: 276.74, temp_max: 276.74, pressure: 1015), weather: [LeBaluchon.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02n")], wind: LeBaluchon.Wind(speed: 5.07, deg: 279), visibility: 10000, dt_txt: "2020-12-10 12:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 279.11, feels_like: 273.27, temp_min: 279.11, temp_max: 279.11, pressure: 1018), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], wind: LeBaluchon.Wind(speed: 5.44, deg: 294), visibility: 10000, dt_txt: "2020-12-10 15:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 280.9, feels_like: 274.88, temp_min: 280.9, temp_max: 280.9, pressure: 1018), weather: [LeBaluchon.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")], wind: LeBaluchon.Wind(speed: 5.67, deg: 309), visibility: 10000, dt_txt: "2020-12-10 18:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 280.17, feels_like: 274.82, temp_min: 280.17, temp_max: 280.17, pressure: 1020), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], wind: LeBaluchon.Wind(speed: 4.76, deg: 320), visibility: 10000, dt_txt: "2020-12-10 21:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 278.53, feels_like: 274.11, temp_min: 278.53, temp_max: 278.53, pressure: 1022), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 3.38, deg: 303), visibility: 10000, dt_txt: "2020-12-11 00:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 277.38, feels_like: 273.5, temp_min: 277.38, temp_max: 277.38, pressure: 1023), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 2.63, deg: 275), visibility: 10000, dt_txt: "2020-12-11 03:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.57, feels_like: 273.47, temp_min: 276.57, temp_max: 276.57, pressure: 1023), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 1.51, deg: 303), visibility: 10000, dt_txt: "2020-12-11 06:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.65, feels_like: 272.69, temp_min: 276.65, temp_max: 276.65, pressure: 1023), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 2.76, deg: 245), visibility: 10000, dt_txt: "2020-12-11 09:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 276.58, feels_like: 272.82, temp_min: 276.58, temp_max: 276.58, pressure: 1023), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01n")], wind: LeBaluchon.Wind(speed: 2.53, deg: 220), visibility: 10000, dt_txt: "2020-12-11 12:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 279.35, feels_like: 274.49, temp_min: 279.35, temp_max: 279.35, pressure: 1023), weather: [LeBaluchon.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")], wind: LeBaluchon.Wind(speed: 4.31, deg: 212), visibility: 10000, dt_txt: "2020-12-11 15:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 282.77, feels_like: 277.74, temp_min: 282.77, temp_max: 282.77, pressure: 1021), weather: [LeBaluchon.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")], wind: LeBaluchon.Wind(speed: 4.79, deg: 215), visibility: 10000, dt_txt: "2020-12-11 18:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.32, feels_like: 279.69, temp_min: 283.32, temp_max: 283.32, pressure: 1020), weather: [LeBaluchon.Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], wind: LeBaluchon.Wind(speed: 3.21, deg: 215), visibility: 10000, dt_txt: "2020-12-11 21:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 282.12, feels_like: 278.49, temp_min: 282.12, temp_max: 282.12, pressure: 1021), weather: [LeBaluchon.Weather(id: 801, main: "Clouds", description: "few clouds", icon: "02n")], wind: LeBaluchon.Wind(speed: 3.73, deg: 217), visibility: 10000, dt_txt: "2020-12-12 00:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 280.87, feels_like: 277.96, temp_min: 280.87, temp_max: 280.87, pressure: 1022), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 2.55, deg: 241), visibility: 10000, dt_txt: "2020-12-12 03:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 280.15, feels_like: 277.85, temp_min: 280.15, temp_max: 280.15, pressure: 1022), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 1.81, deg: 253), visibility: 10000, dt_txt: "2020-12-12 06:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 279.59, feels_like: 277.85, temp_min: 279.59, temp_max: 279.59, pressure: 1022), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 0.9, deg: 276), visibility: 10000, dt_txt: "2020-12-12 09:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 279.58, feels_like: 278.21, temp_min: 279.58, temp_max: 279.58, pressure: 1022), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 0.37, deg: 336), visibility: 10000, dt_txt: "2020-12-12 12:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 281.2, feels_like: 278.91, temp_min: 281.2, temp_max: 281.2, pressure: 1022), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 1.81, deg: 40), visibility: 10000, dt_txt: "2020-12-12 15:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 282.39, feels_like: 279.66, temp_min: 282.39, temp_max: 282.39, pressure: 1020), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 2.64, deg: 68), visibility: 10000, dt_txt: "2020-12-12 18:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 282.78, feels_like: 280.26, temp_min: 282.78, temp_max: 282.78, pressure: 1018), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 2.79, deg: 67), visibility: 10000, dt_txt: "2020-12-12 21:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.03, feels_like: 282.23, temp_min: 283.03, temp_max: 283.03, pressure: 1018), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 0.99, deg: 92), visibility: 10000, dt_txt: "2020-12-13 00:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.62, feels_like: 283.09, temp_min: 283.62, temp_max: 283.62, pressure: 1017), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 0.83, deg: 194), visibility: 10000, dt_txt: "2020-12-13 03:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.75, feels_like: 282.27, temp_min: 283.75, temp_max: 283.75, pressure: 1015), weather: [LeBaluchon.Weather(id: 500, main: "Rain", description: "light rain", icon: "10n")], wind: LeBaluchon.Wind(speed: 2.06, deg: 207), visibility: 10000, dt_txt: "2020-12-13 06:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.49, feels_like: 281.3, temp_min: 283.49, temp_max: 283.49, pressure: 1014), weather: [LeBaluchon.Weather(id: 500, main: "Rain", description: "light rain", icon: "10n")], wind: LeBaluchon.Wind(speed: 2.91, deg: 219), visibility: 10000, dt_txt: "2020-12-13 09:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.47, feels_like: 280.92, temp_min: 283.47, temp_max: 283.47, pressure: 1013), weather: [LeBaluchon.Weather(id: 500, main: "Rain", description: "light rain", icon: "10n")], wind: LeBaluchon.Wind(speed: 3.42, deg: 182), visibility: 10000, dt_txt: "2020-12-13 12:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.96, feels_like: 281.08, temp_min: 283.96, temp_max: 283.96, pressure: 1012), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 3.77, deg: 213), visibility: 10000, dt_txt: "2020-12-13 15:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 284.09, feels_like: 280.1, temp_min: 284.09, temp_max: 284.09, pressure: 1010), weather: [LeBaluchon.Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")], wind: LeBaluchon.Wind(speed: 5.64, deg: 196), visibility: 10000, dt_txt: "2020-12-13 18:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 285.31, feels_like: 282.87, temp_min: 285.31, temp_max: 285.31, pressure: 1008), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")], wind: LeBaluchon.Wind(speed: 3.37, deg: 218), visibility: 10000, dt_txt: "2020-12-13 21:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 284.51, feels_like: 281.65, temp_min: 284.51, temp_max: 284.51, pressure: 1009), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 4.13, deg: 196), visibility: 10000, dt_txt: "2020-12-14 00:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 284.35, feels_like: 281.88, temp_min: 284.35, temp_max: 284.35, pressure: 1008), weather: [LeBaluchon.Weather(id: 500, main: "Rain", description: "light rain", icon: "10n")], wind: LeBaluchon.Wind(speed: 3.58, deg: 263), visibility: 10000, dt_txt: "2020-12-14 03:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 283.21, feels_like: 280.74, temp_min: 283.21, temp_max: 283.21, pressure: 1008), weather: [LeBaluchon.Weather(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 2.74, deg: 274), visibility: 10000, dt_txt: "2020-12-14 06:00:00"), LeBaluchon.List(main: LeBaluchon.Main(temp: 281.79, feels_like: 278.32, temp_min: 281.79, temp_max: 281.79, pressure: 1007), weather: [LeBaluchon.Weather(id: 803, main: "Clouds", description: "broken clouds", icon: "04n")], wind: LeBaluchon.Wind(speed: 3.41, deg: 317), visibility: 10000, dt_txt: "2020-12-14 09:00:00")], city: LeBaluchon.City(name: "New York"))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getWeatherRequest(city: "New York") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let weather):
                XCTAssertNotNil(weather)
                XCTAssertEqual(weather, weatherList)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}



