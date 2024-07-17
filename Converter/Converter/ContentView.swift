//
//  ContentView.swift
//  Converter
//
//  Created by syunaeva on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurment = Measurement(value: input, unit: inputUnit)
        let outputMeasurment = inputMeasurment.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurment)
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
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                    
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
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
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

#Preview {
    ContentView()
}
