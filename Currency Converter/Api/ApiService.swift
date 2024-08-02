//
//  ApiService.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Foundation

class ApiService {
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async -> Result<T, APIError> {
        let urlRequest = endpoint.urlRequest
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodingError(error))
            }
        } catch {
            return .failure(.networkError(error))
        }
    }
    
}

enum APIError: Error {
    case networkError(Error)
    case decodingError(Error)
    case unknownError
}
