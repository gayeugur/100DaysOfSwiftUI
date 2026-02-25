//
//  EditCards.swift
//  Project17-Flashzilla
//
//  Created by gayeugur on 25.02.2026.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: FileManagerViewModel
    @State private var newPrompt = ""
    @State private var newAnswer = ""
     
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card") {
                        vm.addCard(prompt: newPrompt, answer: newAnswer)
                        newPrompt = ""
                        newAnswer = ""
                    }
                }
                
                Section {
                    ForEach(0..<vm.cards.count, id:\.self) { index in
                        VStack(alignment: .leading) {
                            Text(vm.cards[index].prompt)
                                .font(.headline)
                            
                            Text(vm.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: vm.removeCards)
                }
            }
            .navigationTitle("Edit cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: vm.loadData)
        }
    }
    
    func done () {
        dismiss()
    }
}
