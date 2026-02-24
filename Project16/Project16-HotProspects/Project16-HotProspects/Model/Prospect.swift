//
//  Prospect.swift
//  Project16-HotProspects
//
//  Created by gayeugur on 24.02.2026.
//

import SwiftData
import Foundation

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded = Date()
    
    init(name: String, emailAddress: String, isContacted: Bool = false, dateAdded: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }
}
