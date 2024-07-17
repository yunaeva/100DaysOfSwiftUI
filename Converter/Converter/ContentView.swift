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
    
    @FocusState private var inputIsFocused: Bool
    
    let units = ["Feet", "Kilometers", "Meters", "Miles", "Yards"]
    
    var result: String {
        let inputToMetersMultiplier: Double
        let metersToOutputMultiplier: Double
        
        switch inputUnit {
        case "Feet":
            inputToMetersMultiplier = 0.3048
        case "Kilometers":
            inputToMetersMultiplier = 1000
        case "Meters":
            inputToMetersMultiplier = 1.0
        case "Miles":
            inputToMetersMultiplier = 1609.34
        case "Yards":
            inputToMetersMultiplier = 0.912
        default:
            inputToMetersMultiplier = 1.0
        }
        
        switch outputUnit {
        case "Feet":
            metersToOutputMultiplier = 3.280084
        case "Kilometers":
            metersToOutputMultiplier = 0.001
        case "Meters":
            metersToOutputMultiplier = 1.0
        case "Miles":
            metersToOutputMultiplier = 0.000621371
        case "Yards":
            metersToOutputMultiplier = 1.09361
        default:
            metersToOutputMultiplier = 1.0
        }
        
        let inputInMeters = input * inputToMetersMultiplier
        let outtput = inputInMeters * metersToOutputMultiplier
        
        let outputString = outtput.formatted()
        
        return "\(outputString) \(outputUnit.lowercased())"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                    
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                    
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }

                
                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
