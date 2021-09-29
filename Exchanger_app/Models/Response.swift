//
//  Currency.swift
//  Exchanger_app
//
//  Created by Константин Кириллов on 26.09.2021.
//

import Foundation

struct ExchangeResponse: Codable {
    let meta: MetaData
    let response: ResponseDataConvertation
}

struct MetaData: Codable {
    let code: Int
    let disclaimer: String
}

struct ResponseDataConvertation: Codable {
    let dateRequest: String?
    let currencyFrom: String?
    let currencyTo: String?
    let amount: Float?
    let totalAfterConversation: Double?
    
    init() {
        dateRequest = ""
        currencyFrom = ""
        currencyTo = ""
        amount = 0
        totalAfterConversation = 0
    }
    
    init(conversationData: [String: Any]) {
        dateRequest = conversationData["date"] as? String
        currencyFrom = conversationData["from"] as? String
        currencyTo = conversationData["to"] as? String
        amount = conversationData["amount"] as? Float
        totalAfterConversation = conversationData["value"] as? Double
    }
    
    static func getResponseDataConvertation(from value: Any) -> ResponseDataConvertation {
        guard let exchangeResponse = value as? [String: Any] else { return ResponseDataConvertation() }
        guard let responseData = exchangeResponse["response"] as? [String: Any] else { return ResponseDataConvertation() }
        
        return ResponseDataConvertation(conversationData: responseData)
    }
}





