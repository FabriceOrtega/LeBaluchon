//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 08/12/2020.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {
    
    // Outlets target and destination languages
    @IBOutlet weak var originLanguageLabel: UILabel!
    @IBOutlet weak var destinationLanguageLabel: UILabel!
    
    // Text views
    @IBOutlet weak var originTextView: UITextView!
    @IBOutlet weak var destinationTextView: UITextView!
    
    // To get the data from the request
    var translation: TranslateAPI! {
        didSet {
            DispatchQueue.main.async {
                // Attribute result to the destination text view
                self.destinationTextView.text = self.translation.data.translations[0].translatedText
            }
        }
    }
    
    // Instance of the request
    var translationRequest = TranslationRequest(session: URLSession(configuration: .default))
    
    // Parameter to catch the error and display the alert
    var catchError: TranslationError! {
        didSet {
            DispatchQueue.main.async {
                self.alert(title: "Error", message: "Translation Request could not be succesfull !!")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLanguages()
        
        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Set the text fields delegates
        self.originTextView.delegate = self
        self.destinationTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayLanguages()
    }
    
    // Dismiss the keyboard (tap on the view)
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Method to call the request with completion handler
    func getTranslationRequest(text: String) {
        translationRequest.getRequest(text: text) {[weak self] result in
            // Switch for succes or failure
            switch result {
            case .failure(let error):
                print(error)
                self?.catchError = error
            case .success(let translation):
                // if success, attribute the data
                self?.translation = translation
                print(translation)
            }
        }
    }
    
    // Method to display languages
    func displayLanguages(){
        originLanguageLabel.text = Parameters.parameters.originLanguage
        destinationLanguageLabel.text = Parameters.parameters.destinationLanguage
    }
    
    // Get translation button
    @IBAction func getTranslationButton(_ sender: Any) {
        // Check if both languages are the same
        if Parameters.parameters.originLanguage == Parameters.parameters.destinationLanguage {
            // Call the alert method
            alert(title: "Error", message: "Please select to different languages to generate a translation")
        } else {
            // Call the request method with the text view content as parameter
            getTranslationRequest(text: originTextView.text)
        }
    }
    
    // Method to call an alert
    func alert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
}
