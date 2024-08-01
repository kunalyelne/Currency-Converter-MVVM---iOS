//
//  ContentView.swift
//  Currency Converter
//
//  Created by Kunal Yelne on 31/07/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var amount = 0.0
    @State var convertedAmount = 0.0
    @State var sourceCurrency: String = "USD"
    @State var targetCurrency: String = "EUR"
    @FocusState private var amountFieldFocus
    
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
                        
                        Spacer()
                        
                        Picker("To", selection: $targetCurrency) {
                            ForEach(Data.CURRENCY_CODES, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                }
                Section("Amount") {
                    TextField("Enter Amount", value: $amount, format: .currency(code: "\(sourceCurrency)"))
                        .keyboardType(.numberPad)
                        .focused($amountFieldFocus)
                }
                Button(action: {
                    
                }) {
                    Text("Convert")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Section("Amount in \(targetCurrency)") {
                    Text(convertedAmount, format: .currency(code: "\(targetCurrency)"))
                }
            }
            .navigationTitle("Currency Converter")
            .toolbar {
                if amountFieldFocus {
                    Button("Done") {
                        amountFieldFocus.toggle()
                    }
                }
                
            }
        }
    }
}

#Preview {
    HomeScreen()
}
