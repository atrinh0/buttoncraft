//
//  ContentView.swift
//  buttoncraft
//
//  Created by An Trinh on 2/8/20.
//

import SwiftUI

struct DefaultConstants {
    static let scale: Double = 0.85
    static let rotation: Double = 0
    static let blur: Double = 0
    static let color: Color = Color.primary.opacity(0.75)
    static let shouldAnimate: Bool = true
    static let response: Double = 0.35
    static let damping: Double = 0.35
    static let duration: Double = 1
}

struct ContentView: View {
    @Environment(\.openURL) var openURL

    @State private var scale = DefaultConstants.scale
    @State private var rotation = DefaultConstants.rotation
    @State private var blur = DefaultConstants.blur
    @State private var color = DefaultConstants.color
    @State private var animate = DefaultConstants.shouldAnimate
    @State private var response = DefaultConstants.response
    @State private var damping = DefaultConstants.damping
    @State private var duration = DefaultConstants.duration

    @State private var showCode = false
    @State private var showCopied = false

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    randomize()
                } label: {
                    Image(systemName: "shuffle")
                        .font(Font.body.bold())
                        .imageScale(.large)
                        .foregroundColor(Color.primary)
                        .padding()
                }
                .pressableButton(style: getParams(), drawBackground: false)
                Spacer()
                Button {
                    reset()
                } label: {
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
                Button { } label: {
                    Text("tap here")
                        .testButtonStyle()
                }
                .pressableButton(style: getParams())
                Button { } label: {
                    Text("or here")
                        .font(Font.body.bold())
                        .padding()
                }
                .pressableButton(style: getParams(), drawBackground: false)
                Button { } label: {
                    Image(systemName: "star.fill")
                        .testButtonStyle()
                }
                .pressableButton(style: getParams())
            }
            .zIndex(1)
            ScrollView {
                ScrollViewReader { reader in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Scale Effect")
                                .font(Font.body.bold())
                            Spacer()
                            Text("\(scale * 100, specifier: "%.0f")%")
                                .font(Font.body.bold())
                        }
                        Slider(value: $scale, in: 0.05...2, step: 0.05)
                    }
                    .paddedStack()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Rotation Effect")
                                .font(Font.body.bold())
                            Spacer()
                            Text("\(rotation, specifier: "%.0f") degrees")
                                .font(Font.body.bold())
                        }
                        Slider(value: $rotation, in: -360...360, step: 5)
                    }
                    .paddedStack()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Blur Radius")
                                .font(Font.body.bold())
                            Spacer()
                            Text("\(blur, specifier: "%.1f")")
                                .font(Font.body.bold())
                        }
                        Slider(value: $blur, in: 0...15, step: 0.5)
                    }
                    .paddedStack()
                    VStack(alignment: .leading) {
                        ColorPicker("Color", selection: $color)
                            .font(Font.body.bold())
                    }
                    .paddedStack()
                    VStack(alignment: .leading) {
                        Toggle("Animation", isOn: $animate.animation())
                            .font(Font.body.bold())
                            .toggleStyle(SwitchToggleStyle(tint: DefaultConstants.color))
                    }
                    .paddedStack()
                    if animate {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Spring Stiffness")
                                    .font(Font.body.bold())
                                Spacer()
                                Text("\(response, specifier: "%.2f")")
                                    .font(Font.body.bold())
                            }
                            Slider(value: $response, in: 0...1, step: 0.05)
                            Text("(low for zippy 🐇, high for sluggish 🐢)")
                                .font(Font.body.bold())
                        }
                        .paddedStack()
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Spring Damping")
                                    .font(Font.body.bold())
                                Spacer()
                                Text("\(damping, specifier: "%.2f")")
                                    .font(Font.body.bold())
                            }
                            Slider(value: $damping, in: 0.05...1, step: 0.05)
                            Text("(low for bouncier animations 🤪)")
                                .font(Font.body.bold())
                        }
                        .paddedStack()
                    }
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                showCode.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                                withAnimation {
                                    reader.scrollTo(73, anchor: .bottom)
                                }
                            }
                        } label: {
                            Image(systemName: "curlybraces")
                                .font(Font.title2.bold())
                                .imageScale(.large)
                                .foregroundColor(Color.primary)
                                .padding()
                        }
                        .pressableButton(style: getParams(), drawBackground: false)
                        if showCode {
                            Button {
                                goToGithub()
                            } label: {
                                let scale = UIFontMetrics.default.scaledValue(for: 32)
                                Image("mark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: scale, height: scale)
                                    .foregroundColor(Color.primary)
                                    .padding()
                            }
                            .pressableButton(style: getParams(), drawBackground: false)
                        }
                        Spacer()
                    }
                    .padding(.top)
                    if showCode {
                        ZStack(alignment: .bottomTrailing) {
                            Text(generatedCode())
                                .font(Font.custom("Menlo-Regular", size: 12))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                                                .foregroundColor(Color(UIColor.secondarySystemBackground)))
                                .padding()
                            HStack {
                                Button {
                                    copySnippet()
                                } label: {
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
                        HStack(spacing: 30) {
                            Button { } label: {
                                Text("just like that")
                                    .testButtonStyle()
                            }
                            .pressableButton(style: getParams())
                            .id(73)
                            Button { } label: {
                                Image(systemName: "face.smiling")
                                    .testButtonStyle()
                            }
                            .pressableButton(style: getParams())
                        }
                    }
                    Spacer(minLength: 20)
                }
            }
        }
    }
}

extension ContentView {
    private func randomize() {
        withAnimation {
            scale = Double.random(in: 0.5...1.5).rounded(toPlaces: 2)
            rotation = Double.random(in: -45...45).rounded(toPlaces: 0)
            blur = Double.random(in: 0...2).rounded(toPlaces: 1)
            color = Color(red: Double.random(in: 0...1),
                          green: Double.random(in: 0...1),
                          blue: Double.random(in: 0...1),
                          opacity: 1)
            animate = true
            response = Double.random(in: 0...0.6).rounded(toPlaces: 2)
            damping = Double.random(in: 0.05...0.6).rounded(toPlaces: 2)
            duration = DefaultConstants.duration
        }
    }

    private func reset() {
        withAnimation {
            scale = DefaultConstants.scale
            rotation = DefaultConstants.rotation
            blur = DefaultConstants.blur
            color = DefaultConstants.color
            animate = DefaultConstants.shouldAnimate
            response = DefaultConstants.response
            damping = DefaultConstants.damping
            duration = DefaultConstants.duration
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

    // swiftlint:disable function_body_length line_length
    private func generatedCode() -> String {
        return
"""
struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
                            .foregroundColor(configuration.isPressed ? Color(.sRGB, red:\(color.redComponent.rounded(toPlaces: 3)), green:\(color.greenComponent.rounded(toPlaces: 3)), blue:\(color.blueComponent.rounded(toPlaces: 3)), opacity:\(color.alphaComponent.rounded(toPlaces: 2))) : Color.primary))
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

Button(action: { }) {
    Image(systemName: "face.smiling")
        .font(Font.body.bold())
        .imageScale(.large)
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
