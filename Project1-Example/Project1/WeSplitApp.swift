//
//  ContentView.swift
//  Project1
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI

struct ContentView: View {
   let students = ["Harry", "Hermione", "Ron"]
   @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Selected Student",
                          text: $selectedStudent)
            }
        }
    }
}

#Preview {
    ContentView()
}
