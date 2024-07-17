//
//  ContentView.swift
//  Converter
//
//  Created by syunaeva on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @State private var selectedUnits = 0
    
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    // maybe it is better to use dictionary
    let unitTypes = [
        [UnitLength.kilometers, UnitLength.feet,  UnitLength.meters, UnitLength.miles, UnitLength.yards],
        [UnitMass.kilograms, UnitMass.grams, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.seconds, UnitDuration.hours, UnitDuration.minutes]
    ]
    
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
                
                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<conversions.count, id:\.self) {
                        Text(conversions[$0])
                    }
                }
                    
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                    
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
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
            .onChange(of: selectedUnits) {
                let units = unitTypes[selectedUnits]
                inputUnit = units[0]
                outputUnit = units[1]
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
