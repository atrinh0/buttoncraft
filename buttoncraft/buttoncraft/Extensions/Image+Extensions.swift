//
//  Image+Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 28/11/2021.
//

import SwiftUI

extension Image {
    func testButtonStyle() -> some View {
        self.modifier(TestButton())
    }
}
