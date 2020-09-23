//
//  Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 23/9/20.
//

import SwiftUI
import UIKit

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension VStack {
    func paddedStack() -> some View {
        self.modifier(PaddedStyle())
    }
}

extension Image {
    func testButtonStyle() -> some View {
        self.modifier(TestButton())
    }
}

extension Text {
    func testButtonStyle() -> some View {
        self.modifier(TestButton())
    }
}

extension Button {
    func pressableButton(style: ButtonStyleParams, drawBackground: Bool = true) -> some View {
        self.buttonStyle(ButtonPressedStyle(style: style, drawBackground: drawBackground))
    }
}

extension Color {
    var components: (red: Double, green: Double, blue: Double, opacity: Double) {
        typealias NativeColor = UIColor
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            return (0, 0, 0, 0)
        }
        return (Double(r), Double(g), Double(b), Double(o))
    }
}
