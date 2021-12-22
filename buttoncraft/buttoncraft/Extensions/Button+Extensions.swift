//
//  Button+Extensions.swift
//  buttoncraft
//
//  Created by An Trinh on 28/11/2021.
//

import SwiftUI

extension Button {
    func pressableButton(style: ButtonStyleParams, drawBackground: Bool = true) -> some View {
        self.buttonStyle(ButtonPressedStyle(style: style, drawBackground: drawBackground))
    }
}

struct ButtonPressedStyle: ButtonStyle {
    var style: ButtonStyleParams
    var drawBackground: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
                            .foregroundColor(configuration.isPressed ? getRGBColor() : Color.primary)
                            .opacity(drawBackground ? 1 : 0))
            .scaleEffect(configuration.isPressed ? CGFloat(style.scale) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? style.rotation : 0))
            .blur(radius: configuration.isPressed ? CGFloat(style.blur) : 0)
            .animation(style.animate ? Animation.spring(response: style.response,
                                                        dampingFraction: style.damping,
                                                        blendDuration: style.duration) : .none,
                       value: configuration.isPressed)
    }

    private func getRGBColor() -> Color {
        Color(.sRGB,
              red: style.color.redComponent,
              green: style.color.greenComponent,
              blue: style.color.blueComponent,
              opacity: style.color.alphaComponent)
    }
}
