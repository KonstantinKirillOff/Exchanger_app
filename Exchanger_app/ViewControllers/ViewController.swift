//
//  ViewController.swift
//  API_app
//
//  Created by Константин Кириллов on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //Не знаю с чем связано, но не смог сделать аутлет коллекшн и добавить туда нужные кнопки, прошлось делать костыль( Возможно баг нового Xcode
    @IBOutlet weak var rubButtonFrom: UIButton!
    @IBOutlet weak var usdButtonFrom: UIButton!
    @IBOutlet weak var eurButtonFrom: UIButton!
    @IBOutlet weak var rubButtonTo: UIButton!
    @IBOutlet weak var usdButtonTo: UIButton!
    @IBOutlet weak var eurButtonTo: UIButton!
    @IBOutlet weak var currencyButtonFrom: UIButton!
    @IBOutlet weak var currencyButtonTo: UIButton!
    
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var resultTF: UILabel!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
       showHideButtons(forOwner: sender)
    }
    
    @IBAction func currencyTappedFrom(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        currencyButtonFrom.setTitle(title, for: .normal)
        showHideButtons(forOwner: currencyButtonFrom)
    }
    
    
    @IBAction func currencyTappedTp(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        currencyButtonTo.setTitle(title, for: .normal)
        showHideButtons(forOwner: currencyButtonTo)
    }
    
    
    @IBAction func convertation() {
        if amountTF.text == "" {
            let alert = UIAlertController(title: "Не заполнены данные", message: "Необходимо заполнить сумму конвертации!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            
            return
        }
                                            
        let parameters = ["from": currencyButtonFrom.currentTitle ?? "",
                          "to": currencyButtonTo.currentTitle ?? "",
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


// MARK: - Private methods
extension ViewController {
    private func showHideButtons(forOwner ownerButton: UIButton) {
        if ownerButton == currencyButtonFrom {
            for button in [rubButtonFrom, usdButtonFrom, eurButtonFrom] {
                guard let button = button else { continue }
                UIView.animate(withDuration: 0.4) {
                    button.isHidden.toggle()
                    self.view.layoutIfNeeded()
                }
            }
        } else {
            for button in [rubButtonTo, usdButtonTo, eurButtonTo] {
                guard let button = button else { continue }
                UIView.animate(withDuration: 0.4) {
                    button.isHidden.toggle()
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}

