//
//  Text+Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 28/11/2021.
//

import SwiftUI

extension Text {
    func testButtonStyle() -> some View {
        self.modifier(TestButton())
    }
}

struct TestButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.body.bold())
            .imageScale(.large)
            .padding()
            .foregroundColor(Color.primary)
            .colorInvert()
    }
}
