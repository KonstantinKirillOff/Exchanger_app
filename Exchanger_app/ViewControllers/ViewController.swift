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
        fetchCurrencyRate()
    }
    
    private func fetchCurrencyRate() {
        let urlForFetch = "https://api.currencyscoop.com/v1/convert?api_key=ab6104253078d5f620a5d9e3604df589&from=\(currencyFromTF.text?.uppercased() ?? "")&to=\(currencyToTF.text?.uppercased() ?? "")&amount=\(amountTF.text?.uppercased() ?? "")"
        
        guard let url = URL(string: urlForFetch) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let responseFromServer = try JSONDecoder().decode(ExchangeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.resultTF.text = String(format: "%.2f", responseFromServer.response.value)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

