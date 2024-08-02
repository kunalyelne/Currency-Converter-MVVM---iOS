//
//  ApiService.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Foundation
import OSLog

class ApiService {
    
    func request<T: Codable>(_ endpoint: APIEndpoint) async -> Result<T, APIError> {
        let urlRequest = endpoint.urlRequest
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            
            if let response = urlResponse as? HTTPURLResponse {
                os_log("Response status code: %d", log: .default, type: .info, response.statusCode)
            }
            
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
