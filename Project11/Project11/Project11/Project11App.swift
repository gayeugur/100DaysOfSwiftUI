//
//  Project11App.swift
//  Project11
//
//  Created by gayeugur on 22.02.2026.
//

import SwiftUI
import SwiftData

@main
struct Project11App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
