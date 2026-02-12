//
//  ContentView.swift
//  Project1
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State var numberOfPeople = 2
    @State var checkAmount = 0.0
    @State var selectedTip: Int = 10
    let tipPercentages = [10, 15, 20, 25, 30]
    
    var tipAmount: Double {
        checkAmount * Double(selectedTip) / 100
    }

    var grandTotal: Double {
        checkAmount + tipAmount
    }

    var totalPerPerson: Double {
        grandTotal / Double(numberOfPeople + 2)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // 2.section
                Section {
                    Text("Total Amount")
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                }
                
                // 3. section
                Section("How much tip do would you like to leave?") {
                    
                    Picker("", selection: $selectedTip) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0.formatted(.percent))
                        }
                    }.pickerStyle(.segmented)
                    
                }
                
                //4.Section
                Section {
                    Text("Total Amount")
                    Text(
                        grandTotal,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )

                }
                
                //5.Section
                Section {
                    Text("Amount per person")
                    Text(
                        totalPerPerson,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
