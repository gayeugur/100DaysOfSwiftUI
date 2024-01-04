//
//  ContentView.swift
//  Project1
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
           let tipSelection = Double(tipPercentage)

           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue
           let amountPerPerson = grandTotal / peopleCount

           return amountPerPerson
    }
    
    var totalAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
           let tipSelection = Double(tipPercentage)

           let tipValue = checkAmount / 100 * tipSelection
           let grandTotal = checkAmount + tipValue

           return grandTotal
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad).focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section {
                    Text("Amount total")
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section {
                    Text("Amount per person")
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section {
                    Text("How much tip do you want to leave?")
                    
                    /*Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)*/
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }.pickerStyle(.navigationLink)
                    
                }
            }
        }.navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
