//
//  Parameters.swift
//  LeBaluchon
//
//  Created by Fabrice Ortega on 07/12/2020.
//

import Foundation

class Parameters {
    // Pattern singleton
    public static let parameters = Parameters()
    
    // City from origin
    var originCity = "Paris"
    
    // Currency from Origin
    var originCurrency = "EUR"
    
    // Language from origin
    var originLanguage = "en"
    
    // City for vacation
    var destinationCity = "New York"
    
    // Destination currency
    var destinationCurrency = "EUR"
    
    // Destination language
    var destinationLanguage = "en"
    
    // List of languages
    let languages = ["en", "fr", "es", "de", "it", "nl", "pt", "ja", "zh", "hr", "cs", "da", "fi", "el", "hu", "is", "lv", "lt", "lb", "no", "pl", "ro", "ru", "sr", "sk", "sl", "sv", "uk"]
    
    // List of currencies
//    let currencies = ["EUR", "USD", "GBP", "CHF","AUD","CAD","JPY", "CNY", "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTC", "BTN", "BWP", "BYN", "BYR", "BZD", "CDF", "CLF", "CLP", "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "FJD", "FKP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOD", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG", "XAU", "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMK", "ZMW", "ZWL"]
    
    let currencies = ["EUR", "USD", "GBP", "CHF","AUD","CAD","JPY", "CNY"]
    
    // Public init for pattern singleton
    public init() {}
    
    
}
