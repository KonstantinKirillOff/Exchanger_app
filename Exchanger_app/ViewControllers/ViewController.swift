//
//  ViewController.swift
//  API_app
//
//  Created by Константин Кириллов on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyFromTF: UITextField!
    @IBOutlet weak var currencyToTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var resultTF: UILabel!

    @IBAction func convertation() {
        let parameters = ["from": currencyFromTF.text?.uppercased() ?? "",
                          "to": currencyToTF.text?.uppercased() ?? "",
                          "amount": amountTF.text ?? ""]
        
        let url = NetworkManager.shared.getURLWithParameters(from: Link.ConvertationCurrency.rawValue, with: parameters)
        
        NetworkManager.shared.fetchConversationData(fromURL: url) { result in
            switch result {
            case .success(let response):
                self.resultTF.text = "\(response.amount ?? 0) \(response.currencyFrom ?? "") в валюте \(response.currencyTo ?? "") составит \(String(format: "%.2f", response.totalAfterConversation ?? 0)) на \(response.dateRequest ?? "")"
            case .failure(let error):
                print(error)
            }
        }
    }
}

