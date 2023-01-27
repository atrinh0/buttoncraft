<p align="center"><img src="images/taphere.gif" width="190"></p>

<p align="center">
    <img src="https://img.shields.io/badge/iOS-14.0+-blue.svg" />
    <img src="https://img.shields.io/badge/Xcode-13.0+-brightgreen.svg" />
    <img src="https://img.shields.io/badge/Swift-5.5-orange.svg" />
    <img src="https://img.shields.io/badge/SwiftUI-3.0-red.svg" />
</p>

# buttoncraft (SwiftUI App)
> Experimenting with `SwiftUI` whilst creating a practical app to craft that perfect button style.

### ✈️ Testflight

https://testflight.apple.com/join/pZDhygQt

> Last TestFlight bump: 27th January 2023

<img src="images/demo.gif"> <img src="images/copycode.gif">

### 👨🏻‍💻 Code outputted from app

```Swift
struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
                            .foregroundColor(configuration.isPressed ? Color.primary.opacity(0.75) : Color.primary))
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? 0.0 : 0))
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}

extension Button {
    func myButtonStyle() -> some View {
        self.buttonStyle(MyButtonStyle())
    }
}

// to use
Button { } label: {
    Text("just like that")
        .font(Font.body.bold())
        .padding()
        .foregroundColor(Color.primary)
        .colorInvert()
}
.myButtonStyle()

Button { } label: {
    Image(systemName: "face.smiling")
        .font(Font.body.bold())
        .imageScale(.large)
        .padding()
        .foregroundColor(Color.primary)
        .colorInvert()
}
.myButtonStyle()

```

### 🧐 Features

- 🔀 Randomise different settings for inspiration
- Reset to my default style
- Using the new iOS `ColorPicker`
- Copy your perfect masterpiece as a code snippet to your clipboard

### 👨🏻‍⚖️ Disclaimer

> This is posted as a way to share SwiftUI learnings (and is not production level code). Use it at your own risk.
