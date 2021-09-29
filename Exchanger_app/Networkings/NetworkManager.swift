//
//  NetworkManager.swift
//  Exchanger_app
//
//  Created by Константин Кириллов on 27.09.2021.
//
import Foundation
import Alamofire

enum Link: String {
    case currentRateCurrency = "https://api.currencyscoop.com/v1/latest"
    case describeCurrencyes = "https://api.currencyscoop.com/v1/currencies"
    case ConvertationCurrency = "https://api.currencyscoop.com/v1/convert"
}

enum NetError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    let apiKey: String
   
    private init() {
        apiKey = "ab6104253078d5f620a5d9e3604df589"
    }

    func getURLWithParameters(from baseURL: String, with parameters:[String: String]) -> String {
        var fullURLString = "\(baseURL)?api_key=\(apiKey)"

        for parametr in parameters {
            fullURLString += "&\(parametr.key)=\(parametr.value)"
        }
        
        return fullURLString
    }
    
    func fetchConversationData(fromURL url: String, completion: @escaping(Result<ResponseDataConvertation, NetError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let responseDataConvertation = ResponseDataConvertation.getResponseDataConvertation(from: value)
                    DispatchQueue.main.async {
                        completion(.success(responseDataConvertation))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}


