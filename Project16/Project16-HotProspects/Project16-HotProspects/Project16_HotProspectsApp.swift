//
//  Project16_HotProspectsApp.swift
//  Project16-HotProspects
//
//  Created by gayeugur on 24.02.2026.
//

import SwiftUI
import SwiftData

@main
struct Project16_HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
