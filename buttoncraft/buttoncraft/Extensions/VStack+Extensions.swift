//
//  VStack+Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 28/11/2021.
//

import SwiftUI

extension VStack {
    func paddedStack() -> some View {
        self.modifier(PaddedStyle())
    }
}

struct PaddedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(DefaultConstants.color)
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(UIColor.secondarySystemBackground)))
            .padding(.horizontal)
    }
}
