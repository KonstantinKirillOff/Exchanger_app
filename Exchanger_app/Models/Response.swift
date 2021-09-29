//
//  Currency.swift
//  Exchanger_app
//
//  Created by Константин Кириллов on 26.09.2021.
//

struct ExchangeResponse: Decodable {
    let meta: MetaData
    let response: ResponseData
}

struct MetaData: Decodable {
    let code: Int
    let disclaimer: String
}

struct ResponseData: Decodable {
    let timestamp: Int
    let date: String
    let from: String
    let to: String
    let amount: Float
    let value: Float
}


