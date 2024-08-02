//
//  AppDIContainer.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 02/08/24.
//

import Swinject

class AppDIContainer {
    let container: Container
    
    init() {
        container = Container()
        setupDependencies()
    }
    
    private func setupDependencies() {
        container.register(ApiService.self) { _ in ApiService() }
        container.register(Repository.self) { r in
            MainRepository(apiService: r.resolve(ApiService.self)!)
        }
        container.register(HomeScreenViewModel.self) { r in
            HomeScreenViewModel(mainRepository: r.resolve(Repository.self)!)
        }
    }
}
