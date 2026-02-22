//
//  ContentView.swift
//  Project12
//
//  Created by gayeugur on 22.02.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpComing = false
    @State private var path = [User]()
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showingUpComing ? .now : .distantPast,
                      sortOder: sortOrder)
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    let first = User(name: "User 1", city: "Istanbul", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "User 2", city: "Ankara", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "User 3", city: "İzmir", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "User 4", city: "İstanbul", joinDate: .now.addingTimeInterval(86400 * 10))
                    
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
                Button(showingUpComing ? "Show Everyone" : "Show Upcoming") {
                    showingUpComing.toggle()
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                        
                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
            }
        }
    }
}
