//
//  NetworkState.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Foundation

enum NetworkState {
    case Idle
    case Loading
    case Success
    case Error(message: String)
}
