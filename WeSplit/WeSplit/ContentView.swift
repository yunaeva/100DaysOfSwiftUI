//
//  ContentView.swift
//  WeSplit
//
//  Created by syunaeva on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPersentage = 20
    let tepPercentage = [10, 15, 20, 25]
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount,
                          format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
            }
            
            Section {
                Text ( checkAmount,
                       format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }

        }
            
        }
}

#Preview {
    ContentView()
}
