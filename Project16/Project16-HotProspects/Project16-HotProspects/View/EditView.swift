//
//  EditView.swift
//  Project16-HotProspects
//
//  Created by gayeugur on 24.02.2026.
//

import SwiftUI
import SwiftData

struct EditView: View {
    @Bindable var item: Prospect
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $item.name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $item.emailAddress)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }
            .navigationTitle("Edit")
        }
    }
}
