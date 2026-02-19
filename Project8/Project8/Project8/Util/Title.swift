//
//  Title.swift
//  Project8
//
//  Created by gayeugur on 19.02.2026.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
