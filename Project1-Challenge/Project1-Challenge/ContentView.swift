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
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let lengthUnits = ["Meters", "Centimeters", "Feet", "Inches"]
    
    var convertedValue: Double {
        let input = Double(inputValue) ?? 0
        let inputUnit = getUnit(for: fromUnitIndex)
        let outputUnit = getUnit(for: toUnitIndex)
        
        let baseMeasurement = Measurement(value: input, unit: inputUnit)
        let convertedMeasurement = baseMeasurement.converted(to: outputUnit)
        
        return convertedMeasurement.value
    }
    
    func getUnit(for index: Int) -> UnitLength {
        switch index {
        case 0:
            return .meters
        case 1:
            return .centimeters
        case 2:
            return .feet
        case 3:
            return .inches
        default:
            return .meters
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                    Text("Unit to Convert")
                    Picker("Unit to Convert", selection: $fromUnitIndex) {
                        ForEach(0..<lengthUnits.count) {
                            Text(self.lengthUnits[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                .padding()
                
                
                Picker("Dönüştürülecek Birim", selection: $toUnitIndex) {
                    ForEach(0..<lengthUnits.count) {
                        Text(self.lengthUnits[$0])
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                TextField("Write lenght...", text: $inputValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    outputValue = String(format: "%.2f", convertedValue)
                }) {
                    Text("Convert")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Text("Result: \(outputValue)")
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        LengthConverterView()
            .navigationBarTitle("Length Converter")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

