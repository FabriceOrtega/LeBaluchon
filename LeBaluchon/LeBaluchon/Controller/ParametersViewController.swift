//
//  ParametersViewController.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import UIKit

class ParametersViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    
    // Outlets for data from the home place
    @IBOutlet weak var myCityTextField: UITextField!
    @IBOutlet weak var myCurrencyPickerView: UIPickerView!
    @IBOutlet weak var myLanguagePickerView: UIPickerView!
    
    // Destination outlets
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var destinationLanguagePickerView: UIPickerView!
    @IBOutlet weak var destinationCurrencyPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give tags to picker views
        myLanguagePickerView.tag = 1
        myCurrencyPickerView.tag = 2
        destinationLanguagePickerView.tag = 3
        destinationCurrencyPickerView.tag = 4

        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Dismiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveDataButton(_ sender: Any) {
        // Save cities
        Parameters.parameters.originCity = myCityTextField.text ?? ""
        Parameters.parameters.destinationCity = destinationTextField.text ?? ""
        print("Origin")
        print(Parameters.parameters.originCity)
        print(Parameters.parameters.originLanguage)
        print(Parameters.parameters.originCurrency)
        print("Destination")
        print(Parameters.parameters.destinationCity)
        print(Parameters.parameters.destinationLanguage)
        print(Parameters.parameters.destinationCurrency)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return Parameters.parameters.languages.count
        case 2:
            return Parameters.parameters.currencies.count
        case 3:
            return Parameters.parameters.languages.count
        case 4:
            return Parameters.parameters.currencies.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return Parameters.parameters.languages[row]
        case 2:
            return Parameters.parameters.currencies[row]
        case 3:
            return Parameters.parameters.languages[row]
        case 4:
            return Parameters.parameters.currencies[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            Parameters.parameters.originLanguage = Parameters.parameters.languages[row]
        case 2:
            Parameters.parameters.originCurrency = Parameters.parameters.currencies[row]
        case 3:
            Parameters.parameters.destinationLanguage = Parameters.parameters.languages[row]
        case 4:
            Parameters.parameters.destinationCurrency = Parameters.parameters.currencies[row]
        default:
            return
        }
    }

}