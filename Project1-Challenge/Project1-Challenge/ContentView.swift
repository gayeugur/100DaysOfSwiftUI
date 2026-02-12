//
//  ContentView.swift
//  Project1-Challenge
//
//  Created by gayeugur on 4.01.2024.
//
import SwiftUI

struct LengthConverterView: View {
    @State private var fromUnitIndex = 0
    @State private var toUnitIndex = 1
    @State private var inputValue = 0.0
    
    private let unitNames = ["Meters", "Centimeters", "Feet", "Inches"]
    private let unitTypes: [UnitLength] = [
        .meters,
        .centimeters,
        .feet,
        .inches
    ]
    
    var convertedValue: Double {
        let baseMeasurement = Measurement(
            value: inputValue,
            unit: unitTypes[fromUnitIndex]
        )
        
        return baseMeasurement
            .converted(to: unitTypes[toUnitIndex])
            .value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("From") {
                    Picker("Unit", selection: $fromUnitIndex) {
                        ForEach(unitNames.indices, id: \.self) { index in
                            Text(unitNames[index])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("To") {
                    Picker("Unit", selection: $toUnitIndex) {
                        ForEach(unitNames.indices, id: \.self) { index in
                            Text(unitNames[index])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Value") {
                    TextField(
                        "Enter length",
                        value: $inputValue,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                }
                
                Section("Result") {
                    Text(
                        convertedValue,
                        format: .number.precision(.fractionLength(2))
                    )
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}


struct ContentView: View {
    var body: some View {
        LengthConverterView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

