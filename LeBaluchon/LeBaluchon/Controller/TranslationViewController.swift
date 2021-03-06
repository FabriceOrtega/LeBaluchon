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
    
    // Button outlet
    @IBOutlet weak var getTranslationButtonOutlet: UIButton!
    
    // Round corner value
    var cornerRadius: CGFloat = 8
    
    // To get the data from the request
    var translation: TranslateAPI? {
        didSet {
            DispatchQueue.main.async {
                // Attribute result to the destination text view
                self.destinationTextView.text = self.translation?.data.translations[0].translatedText
            }
        }
    }
    
    // Instance of the request
    var translationRequest = TranslationRequest(session: URLSession(configuration: .default))
    
    // Parameter to catch the error and display the alert
    var catchError: TranslationError? {
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
        
        //Round corners
        originTextView.layer.cornerRadius = cornerRadius
        originTextView.layer.borderWidth = 1.0
        destinationTextView.layer.cornerRadius = cornerRadius
        destinationTextView.layer.borderWidth = 1.0
        getTranslationButtonOutlet.layer.cornerRadius = cornerRadius
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
            }
        }
    }
    
    // Method to display languages
    func displayLanguages(){
        originLanguageLabel.text = Parameters.parameters.originLanguage.uppercased()
        destinationLanguageLabel.text = Parameters.parameters.destinationLanguage.uppercased()
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
    
}
