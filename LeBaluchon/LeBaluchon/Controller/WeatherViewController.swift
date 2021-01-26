//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // City labels
    @IBOutlet weak var originCityLabel: UILabel!
    @IBOutlet weak var destinationCityLabel: UILabel!
    
    // Weather image outlets
    @IBOutlet weak var weatherImageOrigin1: UIImageView!
    @IBOutlet weak var weatherImageOrigin2: UIImageView!
    @IBOutlet weak var weatherImageOrigin3: UIImageView!
    @IBOutlet weak var weatherImageDestination1: UIImageView!
    @IBOutlet weak var weatherImageDestination2: UIImageView!
    @IBOutlet weak var weatherImageDestination3: UIImageView!
    
    // Temperature outlets
    @IBOutlet weak var temperatureLabelOrigin1: UILabel!
    @IBOutlet weak var temperatureLabelOrigin2: UILabel!
    @IBOutlet weak var temperatureLabelOrigin3: UILabel!
    @IBOutlet weak var temperatureLabelDestination1: UILabel!
    @IBOutlet weak var temperatureLabelDestination2: UILabel!
    @IBOutlet weak var temperatureLabelDestination3: UILabel!
    
    
    // To get the data from the request for the origin
    var weatherOrigin: WeatherAPI? {
        didSet {
            DispatchQueue.main.async {
                self.displayCities()
                self.displayTemperaturesOrigin()
                self.attributeWeatherImageOrigin()
            }
        }
    }
    
    // To get the data from the request for the destination
    var weatherDestination: WeatherAPI?{
        didSet {
            DispatchQueue.main.async {
                self.displayCities()
                self.displayTemperaturesDestination()
                self.attributeWeatherImageDestination()
            }
        }
    }
    
    // Parameter to catch the error and display the alert
    var catchError: WeatherRequestError? {
        didSet {
            DispatchQueue.main.async {
                self.alert(title: "Error", message: "Weather Request could not be succesfull !!")
            }
        }
    }
    
    // Instance of the request
    var weatherRequest = WeatherRequest(session: URLSession(configuration: .default))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Call requests of both cities
        callRequests()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Call requests of both cities
        callRequests()
        
    }
    
    // Method to call the request with completion handler
    func getWeatherRequest(city: String) {
//        // Transform the string to remve the space
//        let transfomedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        // Call the request
        weatherRequest.getWeatherRequest(city: city) {[weak self] result in
            // Switch for succes or failure
            switch result {
            case .failure(let error):
                print(error)
                self?.catchError = error
            case .success(let weather):
                // if success, attribute the data
                if city == Parameters.parameters.originCity {
                    self?.weatherOrigin = weather
                } else if city == Parameters.parameters.destinationCity {
                    self?.weatherDestination = weather
                }
            }
        }
    }
    
    // Method to call the requests of both cities
    func callRequests(){
        if Parameters.parameters.originCity == "" || Parameters.parameters.destinationCity == "" {
            alert(title: "Error", message: "Please enter origin and destination cities before checking the weather")
        } else {
            // Do the request of origin city
            getWeatherRequest(city: Parameters.parameters.originCity)
            // Do the request of destination city
            getWeatherRequest(city: Parameters.parameters.destinationCity)
        }
    }
    
    // Method to update the cities name
    func displayCities() {
        originCityLabel.text = Parameters.parameters.originCity
        destinationCityLabel.text = Parameters.parameters.destinationCity
    }
    
    // Method to update the temperature labels
    func displayTemperaturesOrigin() {
        // Units
        let units = "°C"
        
        if let origin = weatherOrigin {
            // Attribute the data for today
            temperatureLabelOrigin1.text = String(round(10*origin.list[0].main.calcultedCelciusTemp)/10) + units
            
            // Attribute the data for tomorrow same hour (index 8)
            temperatureLabelOrigin2.text = String(round(10*origin.list[8].main.calcultedCelciusTemp)/10) + units
            
            // Attribute the data for the day after same hour (index 16)
            temperatureLabelOrigin3.text = String(round(10*origin.list[16].main.calcultedCelciusTemp)/10) + units
        }
        
        
    }
    
    // Method to update the temperature labels
    func displayTemperaturesDestination() {
        // Units
        let units = "°C"
        
        if let destination = weatherDestination {
            // Attribute the data for today
            temperatureLabelDestination1.text = String(round(10*destination.list[0].main.calcultedCelciusTemp)/10) + units
            
            // Attribute the data for tomorrow same hour (index 8)
            temperatureLabelDestination2.text = String(round(10*destination.list[8].main.calcultedCelciusTemp)/10) + units
            
            // Attribute the data for the day after same hour (index 16)
            temperatureLabelDestination3.text = String(round(10*destination.list[16].main.calcultedCelciusTemp)/10) + units
        }
        
        
    }
    
    // Method to attribute the images from origin city
    func attributeWeatherImageOrigin(){
        if let origin = weatherOrigin {
            weatherImageOrigin1.image = attributeWeatherImage(icon: origin.list[0].weather[0].icon)
            weatherImageOrigin2.image = attributeWeatherImage(icon: origin.list[8].weather[0].icon)
            weatherImageOrigin3.image = attributeWeatherImage(icon: origin.list[16].weather[0].icon)
        }
    }
    
    // Method to attribute the images from origin city
    func attributeWeatherImageDestination(){
        if let destination = weatherDestination {
            weatherImageDestination1.image = attributeWeatherImage(icon: destination.list[0].weather[0].icon)
            weatherImageDestination2.image = attributeWeatherImage(icon: destination.list[8].weather[0].icon)
            weatherImageDestination3.image = attributeWeatherImage(icon: destination.list[16].weather[0].icon)
        }
    }
    
    // Method to attribute the image
    func attributeWeatherImage(icon: String) -> UIImage? {
        // Atribute weather image
        var imageName = "folder.badge.questionmark"
        
        switch icon {
        case "01d":
            imageName = "sun.max"
        case "01n":
            imageName = "moon.fill"
        case "02d":
            imageName = "cloud.sun"
        case "02n":
            imageName = "cloud.moon.fill"
        case "03d":
            imageName = "cloud"
        case "03n":
            imageName = "cloud.fill"
        case "04d":
            imageName = "cloud"
        case "04n":
            imageName = "cloud.fill"
        case "09d":
            imageName = "cloud.drizzle"
        case "09n":
            imageName = "cloud.drizzle.fill"
        case "10d":
            imageName = "cloud.sun.rain"
        case "10n":
            imageName = "cloud.moon.rain.fill"
        case "11d":
            imageName = "cloud.bolt"
        case "11n":
            imageName = "cloud.bolt.fill"
        case "13d":
            imageName = "snow"
        case "13n":
            imageName = "snow"
        case "50d":
            imageName = "wind"
        case "50n":
            imageName = "wind"
        default:
            imageName = "folder.badge.questionmark"
        }
        
        return UIImage(named: imageName)
    }

}
