//
//  ApiUtils.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIEndpoint {
    case getExchangeRate(exchangeRateRequest: ExchangeRateRequest)
    
    var baseURL: URL {
        return URL(string: "https://v6.exchangerate-api.com/v6")!
    }
    
    var apiKey: String {
        return ""
    }
    
    var path: String {
        switch self {
        case .getExchangeRate(let exchangeRateRequest):
            return "/pair/\(exchangeRateRequest.fromCurrency)/\(exchangeRateRequest.toCurrrency)/\(exchangeRateRequest.amount)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getExchangeRate:
            return .get
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL.appending(path: apiKey).appending(path: path))
        request.httpMethod = method.rawValue
        
        switch self {
        default:
            break
        }
        
        return request
    }
}
