//
//  HomeScreenViewModel.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    
    @Published var networkState: NetworkState = .Idle
    @Published var exchangeRateResponse: ExchangeRateResponse?
    
    private let mainRepository: Repository
    
    init(mainRepository: Repository) {
        self.mainRepository = mainRepository
    }
    
    func getExchangeRate(exchangeRateRequest: ExchangeRateRequest) {
        Task {
            await MainActor.run { networkState = .Loading }
            let result: Result<ExchangeRateResponse, APIError> = await mainRepository.getConvertedAmount(exchangeRateRequest: exchangeRateRequest)
            await MainActor.run {
                switch result {
                case .success(let exchangeRateResponse):
                    self.exchangeRateResponse = exchangeRateResponse
                    networkState = .Success
                case .failure(let apiError):
                    networkState = .Error(message: apiError.localizedDescription)
                }
            }
        }
    }
    
    func resetData() {
        networkState = .Idle
        exchangeRateResponse = nil
    }
}
