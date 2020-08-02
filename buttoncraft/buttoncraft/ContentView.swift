//
//  ContentView.swift
//  buttoncraft
//
//  Created by An Trinh on 2/8/20.
//

import SwiftUI

struct ButtonStyleParams {
    let scale: Double
    let rotation: Double
    let blur: Double
    let color: Color
    let animate: Bool
    let response: Double
    let damping: Double
    let duration: Double
}

let DEFAULT_SCALE: Double = 0.85
let DEFAULT_ROTATION: Double = 0
let DEFAULT_BLUR: Double = 0
let DEFAULT_COLOR: Color = Color.primary.opacity(0.75)
let DEFAULT_ANIMATE: Bool = true
let DEFAULT_RESPONSE: Double = 0.35
let DEFAULT_DAMPING: Double = 0.35
let DEFAULT_DURATION: Double = 1

struct ContentView: View {
    @State private var scale: Double = DEFAULT_SCALE
    @State private var rotation: Double = DEFAULT_ROTATION
    @State private var blur: Double = DEFAULT_BLUR
    @State private var color: Color = DEFAULT_COLOR
    @State private var animate: Bool = DEFAULT_ANIMATE
    @State private var response: Double = DEFAULT_RESPONSE
    @State private var damping: Double = DEFAULT_DAMPING
    @State private var duration: Double = DEFAULT_DURATION
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { randomize() }) {
                    Image(systemName: "shuffle")
                        .font(Font.body.bold())
                        .imageScale(.large)
                        .foregroundColor(Color.primary)
                        .padding()
                }
                .pressableButton(style: getParams(), drawBackground: false)
                Spacer()
                Button(action: { reset() }) {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .font(Font.title2.bold())
                        .imageScale(.large)
                        .foregroundColor(Color.primary)
                        .padding()
                }
                .pressableButton(style: getParams(), drawBackground: false)
            }
            .overlay(Text("buttoncraft")
                        .font(Font.largeTitle.bold()))
            HStack(spacing: 30) {
                Button(action: { }) {
                    Text("tap here")
                        .testButtonStyle()
                }
                .pressableButton(style: getParams())
                Button(action: { }) {
                    Text("or here")
                        .font(Font.body.bold())
                        .padding()
                }
                .pressableButton(style: getParams(), drawBackground: false)
                Button(action: { }) {
                    Image(systemName: "star.fill")
                        .testButtonStyle()
                }
                .pressableButton(style: getParams())
            }
            .padding()
            ScrollView {
                VStack {
                    Slider(value: $scale, in: 0.05...2, step: 0.05)
                    Text("Scale Effect: \(scale * 100, specifier: "%.0f")%")
                        .font(Font.title3.bold())
                    Slider(value: $rotation, in: -360...360, step: 5)
                    Text("Rotation Effect: \(rotation, specifier: "%.0f") degrees")
                        .font(Font.title3.bold())
                    Slider(value: $blur, in: 0...15, step: 0.5)
                    Text("Blur Radius: \(blur, specifier: "%.1f")")
                        .font(Font.title3.bold())
                    ColorPicker("Color", selection: $color)
                        .font(Font.title3.bold())
                        .padding()
                    Toggle("Animate", isOn: $animate.animation())
                        .font(Font.title3.bold())
                        .toggleStyle(SwitchToggleStyle(tint: DEFAULT_COLOR))
                        .padding()
                    if animate {
                        Slider(value: $response, in: 0...1, step: 0.05)
                        Text("Spring Stiffness: \(response, specifier: "%.2f")\n(0 being 🐇 and 1 being 🐢)")
                            .font(Font.title3.bold())
                            .multilineTextAlignment(.center)
                        Slider(value: $damping, in: 0.05...1, step: 0.05)
                        Text("Spring Damping: \(damping, specifier: "%.2f")\n(0 is bouncy 🤪)")
                            .font(Font.title3.bold())
                            .multilineTextAlignment(.center)
//                        Slider(value: $duration, in: 0...60, step: 1)
//                        Text("Spring Duration: \(duration, specifier: "%.2f")")
//                            .font(Font.title3.bold())
                    }
                }
                .accentColor(DEFAULT_COLOR)
                .padding(30)
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .foregroundColor(Color.primary.opacity(0.05)))
                .padding()
            }
        }
    }
    
    private func randomize() {
        withAnimation {
            scale = Double.random(in: 0.5...1.5)
            rotation = Double.random(in: -45...45)
            blur = Double.random(in: 0...2)
            color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
            animate = true
            response = Double.random(in: 0...0.6)
            damping = Double.random(in: 0.05...0.6)
            duration = DEFAULT_DURATION
        }
    }
    
    private func reset() {
        withAnimation {
            scale = DEFAULT_SCALE
            rotation = DEFAULT_ROTATION
            blur = DEFAULT_BLUR
            color = DEFAULT_COLOR
            animate = DEFAULT_ANIMATE
            response = DEFAULT_RESPONSE
            damping = DEFAULT_DAMPING
            duration = DEFAULT_DURATION
        }
    }
    
    private func getParams() -> ButtonStyleParams {
        return ButtonStyleParams(scale: scale,
                                 rotation: rotation,
                                 blur: blur,
                                 color: color,
                                 animate: animate,
                                 response: response,
                                 damping: damping,
                                 duration: duration)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Button

struct TestButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.body.bold())
            .imageScale(.large)
            .foregroundColor(Color.primary)
            .colorInvert()
            .padding()
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

struct ButtonPressedStyle: ButtonStyle {
    var style: ButtonStyleParams
    var drawBackground: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
                            .foregroundColor(configuration.isPressed ? style.color : Color.primary)
                            .opacity(drawBackground ? 1 : 0))
            .scaleEffect(configuration.isPressed ? CGFloat(style.scale) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? style.rotation : 0))
            .blur(radius: configuration.isPressed ? CGFloat(style.blur) : 0)
            .animation(style.animate ? Animation.spring(response: style.response, dampingFraction: style.damping, blendDuration: style.duration) : .none)
    }
}

extension Button {
    func pressableButton(style: ButtonStyleParams, drawBackground: Bool = true) -> some View {
        self.buttonStyle(ButtonPressedStyle(style: style, drawBackground: drawBackground))
    }
}
