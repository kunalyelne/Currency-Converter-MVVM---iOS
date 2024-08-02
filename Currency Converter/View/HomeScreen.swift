//
//  ContentView.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 31/07/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var amount: Double = 0.0
    @State var sourceCurrency: String = "USD"
    @State var targetCurrency: String = "EUR"
    @State var hasReset: Bool = true
    
    @FocusState private var amountFieldFocus: Bool
    
    @StateObject private var homeScreenViewModel: HomeScreenViewModel
    
    init(homeScreenViewModel: HomeScreenViewModel) {
        _homeScreenViewModel = StateObject(wrappedValue: homeScreenViewModel)
    }
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "\(sourceCurrency)"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Currency") {
                    HStack(spacing: 20) {
                        Picker("From", selection: $sourceCurrency) {
                            ForEach(Data.CURRENCY_CODES, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: sourceCurrency) { _,_ in
                            resetAmount()
                        }
                        
                        Spacer()
                        
                        Picker("To", selection: $targetCurrency) {
                            ForEach(Data.CURRENCY_CODES, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: targetCurrency) { _,_ in
                            resetAmount()
                        }
                    }
                    
                }
                Section("Amount in \(sourceCurrency)") {
                    TextField("Enter Amount", value: $amount, formatter: formatter)
                        .keyboardType(.numberPad)
                        .focused($amountFieldFocus)
                        .onChange(of: amount) { _ , newValue in
                            amount = round(newValue * 100) / 100
                        }
                        .onTapGesture {
                            if !hasReset {
                                homeScreenViewModel.resetData()
                                hasReset = true
                            }
                        }
                }
                Button(action: {
                    homeScreenViewModel.getExchangeRate(exchangeRateRequest: ExchangeRateRequest(fromCurrency: sourceCurrency, toCurrrency: targetCurrency, amount: amount))
                    hasReset = false
                }) {
                    Text("Convert")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Section("Amount in \(targetCurrency)") {
                    Text(homeScreenViewModel.exchangeRateResponse?.conversionResult ?? 0.0, format: .currency(code: "\(targetCurrency)"))
                }
                
                VStack(alignment: .center) {
                    switch homeScreenViewModel.networkState {
                    case .Idle:
                        EmptyView()
                    case .Loading:
                        ProgressView("Loading...")
                    case .Success:
                        Section {
                            Text("Exchange rate calculated!")
                                .foregroundColor(.blue)
                        }
                    case .Error(let message):
                        Section {
                            Text("Error occurred :( \(message)")
                                .foregroundColor(.red)
                        }
                    }
                }
                
            }
            .navigationTitle("Currency Converter")
            .toolbar {
                if amountFieldFocus {
                    Button("Done") {
                        amountFieldFocus = false
                    }
                }
                
            }
        }
    }
    
    private func resetAmount() {
        amount = 0.0
    }
}

#Preview {
    let container = AppDIContainer().container
    let homeScreenViewModel = container.resolve(HomeScreenViewModel.self)!
    return HomeScreen(homeScreenViewModel: homeScreenViewModel)
}
