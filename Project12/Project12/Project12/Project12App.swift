//
//  Project12App.swift
//  Project12
//
//  Created by gayeugur on 22.02.2026.
//

import SwiftUI
import SwiftData

@main
struct Project12App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
