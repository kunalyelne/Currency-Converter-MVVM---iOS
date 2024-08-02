//
//  Repository.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 01/08/24.
//

import Foundation

protocol Repository {
    func getConvertedAmount(exchangeRateRequest: ExchangeRateRequest) async -> Result<ExchangeRateResponse, APIError>
}
