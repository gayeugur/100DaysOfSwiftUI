//
//  AddView.swift
//  Project7
//
//  Created by gayeugur on 6.01.2024.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var type = "Personal"
    @State private var currencyCode = "USD"
    @State private var amount = 0.0

    var expenses: Expenses

    let types = ["Business", "Personal"]
    let moneyCode = ["USD", "EUR", "TL"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Money Code", selection: $currencyCode) {
                    ForEach(moneyCode, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name,
                                           type: type,
                                           amount: amount,
                                           currencyCode: currencyCode)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
