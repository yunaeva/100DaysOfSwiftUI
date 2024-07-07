//
//  ContentView.swift
//  Converter
//
//  Created by syunaeva on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    
    let units = ["Feet", "Kilometers", "Meters", "Miles", "Yards"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
