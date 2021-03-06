//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import UIKit

class CurrencyViewController: UIViewController, UITextFieldDelegate {
    
    // Rate outlet
    @IBOutlet weak var rateLabel: UILabel!
    
    // Currency labels
    @IBOutlet weak var originCurrencyLabel: UILabel!
    @IBOutlet weak var destinationCurrencyLabel: UILabel!
    
    // Text fields
    @IBOutlet weak var originAmountTextField: UITextField!
    @IBOutlet weak var destinationAmountTextField: UITextField!
    
    // Button outlets
    @IBOutlet weak var originButtonOutlet: UIButton!
    @IBOutlet weak var destinationButtonOutlet: UIButton!
    
    // Round corner value
    var cornerRadius: CGFloat = 8
    
    
    // To get the data from the request
    var currency: CurrencyAPI? {
        didSet {
            DispatchQueue.main.async {
                self.attributeRate()
            }
        }
    }
    
    // Instance of the request
    var currencyRequest = CurrencyRequest(session: URLSession(configuration: .default))
    
    // Parameter to catch the error and display the alert
    var catchError: CurrencyError? {
        didSet {
            DispatchQueue.main.async {
                self.alert(title: "Error", message: "Currency Request could not be succesfull !!")
            }
        }
    }
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencyRequest()
        displayCurrencies()
        
        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Set the text fields delegates
        self.originAmountTextField.delegate = self
        self.destinationAmountTextField.delegate = self
        
        //Round corners
        originAmountTextField.layer.cornerRadius = cornerRadius
        originAmountTextField.layer.borderWidth = 1.0
        destinationAmountTextField.layer.cornerRadius = cornerRadius
        destinationAmountTextField.layer.borderWidth = 1.0
        originButtonOutlet.layer.cornerRadius = cornerRadius
        destinationButtonOutlet.layer.cornerRadius = cornerRadius
    }
    
    // View did appear
    override func viewDidAppear(_ animated: Bool) {
        getCurrencyRequest()
        displayCurrencies()
    }
    
    // Dismiss the keyboard (tap on the view)
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Dismiss the keyboard (Done)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
    
    // call the request with completion handler
    func getCurrencyRequest() {
        currencyRequest.getRequest {[weak self] result in
            // Switch for succes or failure
            switch result {
            case .failure(let error):
                print(error)
                self?.catchError = error
            case .success(let currency):
                // if success, attribute the data
                self?.currency = currency
            }
        }
    }

    // Method to attribute correct rate
    func attributeRate() {
        let rateText = "Rate : "
        
        if let rates = currency?.rates {
            switch Parameters.parameters.destinationCurrency {
            case "EUR":
                Currency.currency.rate = rates.EUR
                return rateLabel.text = rateText + String(rates.EUR)
            case "USD":
                Currency.currency.rate = rates.USD
                return rateLabel.text = rateText + String(rates.USD)
            case "GBP":
                Currency.currency.rate = rates.GBP
                return rateLabel.text = rateText + String(rates.GBP)
            case "CHF":
                Currency.currency.rate = rates.CHF
                return rateLabel.text = rateText + String(rates.CHF)
            case "AUD":
                Currency.currency.rate = rates.AUD
                return rateLabel.text = rateText + String(rates.AUD)
            case "CAD":
                Currency.currency.rate = rates.CAD
                return rateLabel.text = rateText + String(rates.CAD)
            case "JPY":
                Currency.currency.rate = rates.JPY
                return rateLabel.text = rateText + String(rates.JPY)
            case "CNY":
                Currency.currency.rate = rates.CNY
                return rateLabel.text = rateText + String(rates.CNY)
            default:
                return
            }
        }
        
        
    }
    
    // Method to display the currencies
    func displayCurrencies() {
        // Change the labels
        originCurrencyLabel.text = Parameters.parameters.originCurrency
        destinationCurrencyLabel.text = Parameters.parameters.destinationCurrency
        
        // Change the title of the buttons
        let textButton = "Get in "
        originButtonOutlet.setTitle(textButton + Parameters.parameters.destinationCurrency, for: .normal)
        destinationButtonOutlet.setTitle(textButton + Parameters.parameters.originCurrency, for: .normal)
    }
    
    
    @IBAction func originButton(_ sender: Any) {
        if originAmountTextField.text == "" {
            // If no text, show an alert
            alert(title: "Error", message: "Please enter an amount to convert")
        } else {
            // Attribute the amount from the text field
            Currency.currency.originAmount = Double(originAmountTextField.text ?? "")
            // Do the calculation
            Currency.currency.calculateOriginToDestination()
            // Diplay the result in the destination text field
            if let destinationAmount = Currency.currency.destinationAmount {
                destinationAmountTextField.text = String(destinationAmount)
            }
        }
    }
    
    @IBAction func destinationButton(_ sender: Any) {
        if destinationAmountTextField.text == "" {
            // If no text, show an alert
            alert(title: "Error", message: "Please enter an amount to convert")
        } else {
            // Attribute the amount from the text field
            Currency.currency.destinationAmount = Double(destinationAmountTextField.text ?? "")
            // Do the calculation
            Currency.currency.calculateDestinationToOrigin()
            // Diplay the result in the origin text field
            if let originAmount = Currency.currency.originAmount {
                originAmountTextField.text = String(originAmount)
            }
        }
    }
    
}
