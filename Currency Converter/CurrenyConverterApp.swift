//
//  Currency_ConverterApp.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 31/07/24.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    
    let container = AppDIContainer().container
    
    var body: some Scene {
        WindowGroup {
            let homeScreenViewModel = container.resolve(HomeScreenViewModel.self)!
            HomeScreen(homeScreenViewModel: homeScreenViewModel)
        }
    }
}
