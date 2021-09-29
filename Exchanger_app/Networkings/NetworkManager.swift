//
//  NetworkManager.swift
//  Exchanger_app
//
//  Created by Константин Кириллов on 27.09.2021.
//
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    static let baseURL = "https://api.currencyscoop.com/v1/convert"
    static let apiKey = "ab6104253078d5f620a5d9e3604df589"
    
    var currecyFrom = ""
    var currencyTo = ""
    var amountToConvertation: Float = 0
    
    func getFullURL() -> String {
        
        let fullURLString = """
        https://api.currencyscoop.com/v1/convert?api_key=ab6104253078d5f620a5d9e3604df589
        &from=\(currecyFrom)
        &to=\(currencyTo)
        &amount=\(amountToConvertation)
        """
        
        return fullURLString
    }
}


