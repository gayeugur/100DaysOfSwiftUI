//
//  Card.swift
//  Project17-Flashzilla
//
//  Created by gayeugur on 25.02.2026.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
}
