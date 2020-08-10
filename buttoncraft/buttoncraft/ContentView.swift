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
    @Environment(\.openURL) var openURL
    
    @State private var scale = DEFAULT_SCALE
    @State private var rotation = DEFAULT_ROTATION
    @State private var blur = DEFAULT_BLUR
    @State private var color = DEFAULT_COLOR
    @State private var animate = DEFAULT_ANIMATE
    @State private var response = DEFAULT_RESPONSE
    @State private var damping = DEFAULT_DAMPING
    @State private var duration = DEFAULT_DURATION
    
    @State private var showCode = false
    @State private var showCopied = false
    
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
            .zIndex(1)
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
            .zIndex(1)
            ScrollView {
                ScrollViewReader { reader in
                    VStack(alignment: .leading) {
                        Slider(value: $scale, in: 0.05...2, step: 0.05)
                        Text("Scale Effect: \(scale * 100, specifier: "%.0f")%")
                            .font(Font.body.bold())
                        Slider(value: $rotation, in: -360...360, step: 5)
                        Text("Rotation Effect: \(rotation, specifier: "%.0f") degrees")
                            .font(Font.body.bold())
                        Slider(value: $blur, in: 0...15, step: 0.5)
                        Text("Blur Radius: \(blur, specifier: "%.1f")")
                            .font(Font.body.bold())
                        ColorPicker("Color", selection: $color)
                            .font(Font.body.bold())
                            .padding(.vertical)
                        Toggle("Animate", isOn: $animate.animation())
                            .font(Font.body.bold())
                            .toggleStyle(SwitchToggleStyle(tint: DEFAULT_COLOR))
                            .padding(.vertical)
                        if animate {
                            Slider(value: $response, in: 0...1, step: 0.05)
                            Text("Spring Stiffness: \(response, specifier: "%.2f")")
                                .font(Font.body.bold())
                                .padding(.bottom, 10)
                            Text("(low for zippy 🐇, high for sluggish 🐢)")
                                .font(Font.body.bold())
                            Slider(value: $damping, in: 0.05...1, step: 0.05)
                            Text("Spring Damping: \(damping, specifier: "%.2f")")
                                .font(Font.body.bold())
                                .padding(.bottom, 10)
                            Text("(low for bouncier animations 🤪)")
                                .font(Font.body.bold())
                        }
                    }
                    .accentColor(DEFAULT_COLOR)
                    .padding(30)
                    .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .foregroundColor(Color.primary.opacity(0.05)))
                    .padding()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showCode.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                                withAnimation {
                                    reader.scrollTo(73, anchor: .bottom)
                                }
                            }
                        }) {
                            Image(systemName: "curlybraces")
                                .font(Font.title2.bold())
                                .imageScale(.large)
                                .foregroundColor(Color.primary)
                                .padding()
                        }
                        .pressableButton(style: getParams(), drawBackground: false)
                        Spacer()
                    }
                    if showCode {
                        ZStack(alignment: .bottomTrailing) {
                            Text(generatedCode())
                                .font(Font.caption2.bold())
                                .padding(30)
                                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                                .foregroundColor(Color.primary.opacity(0.05)))
                                .padding()
                            HStack {
                                Button(action: {
                                    copySnippet()
                                }) {
                                    Image(systemName: showCopied ? "checkmark" : "doc.on.doc.fill")
                                        .font(Font.body.bold())
                                        .imageScale(.large)
                                        .foregroundColor(Color.primary)
                                }
                                .pressableButton(style: getParams(), drawBackground: false)
                                if showCopied {
                                    Text("Copied")
                                        .font(Font.body.bold())
                                }
                            }
                            .padding(40)
                        }
                        HStack {
                            Button(action: { }) {
                                Text("just like that")
                                    .font(Font.body.bold())
                                    .padding()
                                    .foregroundColor(Color.primary)
                                    .colorInvert()
                            }
                            .pressableButton(style: getParams())
                            .id(73)
                            Button(action: {
                                goToGithub()
                            }) {
                                Image(systemName: "safari.fill")
                                    .font(Font.title2.bold())
                                    .imageScale(.large)
                                    .foregroundColor(Color.primary)
                                    .padding()
                            }
                            .pressableButton(style: getParams(), drawBackground: false)
                        }
                    }
                    Spacer(minLength: 20)
                }
            }
        }
    }
    
    private func randomize() {
        withAnimation {
            scale = Double.random(in: 0.5...1.5).rounded(toPlaces: 2)
            rotation = Double.random(in: -45...45).rounded(toPlaces: 0)
            blur = Double.random(in: 0...2).rounded(toPlaces: 1)
            color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
            animate = true
            response = Double.random(in: 0...0.6).rounded(toPlaces: 2)
            damping = Double.random(in: 0.05...0.6).rounded(toPlaces: 2)
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
    
    private func generatedCode() -> String {
        return """
            struct MyButtonStyle: ButtonStyle {
                func makeBody(configuration: Self.Configuration) -> some View {
                    configuration.label
                        .background(Capsule()
                                        .foregroundColor(configuration.isPressed ? Color.gray : Color.primary)) // replace gray
                        .scaleEffect(configuration.isPressed ? CGFloat(\(scale)) : 1.0)
                        .rotationEffect(.degrees(configuration.isPressed ? \(rotation) : 0))
                        .blur(radius: configuration.isPressed ? CGFloat(\(blur)) : 0)
                        .animation(\(animate ? "Animation.spring(response: \(response), dampingFraction: \(damping), blendDuration: 1)" : ".none"))
                }
            }
            
            extension Button {
                func myButtonStyle() -> some View {
                    self.buttonStyle(MyButtonStyle())
                }
            }
            
            // to use
            Button(action: { }) {
                Text("just like that")
                    .font(Font.body.bold())
                    .padding()
                    .foregroundColor(Color.primary)
                    .colorInvert()
            }
            .myButtonStyle()
        """
    }
    
    private func copySnippet() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = generatedCode()
        
        withAnimation {
            showCopied = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showCopied = false
                }
            }
        }
    }
    
    private func goToGithub() {
        openURL(URL(string: "https://github.com/atrinh0/buttoncraft")!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

// MARK: - Button

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
