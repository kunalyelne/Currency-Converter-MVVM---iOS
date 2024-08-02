//
//  MainRepository.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 01/08/24.
//

import Foundation

class MainRepository: Repository {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getConvertedAmount(exchangeRateRequest: ExchangeRateRequest) async -> Result<ExchangeRateResponse, APIError> {
        return await apiService.request(.getExchangeRate(exchangeRateRequest: exchangeRateRequest))
    }
}
