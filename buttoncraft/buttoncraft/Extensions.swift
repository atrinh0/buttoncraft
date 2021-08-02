//
//  Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 23/9/20.
//

import SwiftUI
import UIKit

extension Double {
    func rounded(toPlaces places: Int) -> Double {
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
    var redComponent: Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return 0
        }
        return red
    }

    var greenComponent: Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return 0
        }
        return green
    }

    var blueComponent: Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return 0
        }
        return blue
    }

    var alphaComponent: Double {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        guard UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return 0
        }
        return alpha
    }
}
