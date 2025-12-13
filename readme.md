# ADAnimatedUI

A lightweight Swift package providing **animated, fully configurable UI elements**
for iOS and macOS.

ADAnimatedUI offers smooth, performant animations that can be used as
**backgrounds or standalone UI components** in any SwiftUI layout.
The package is designed to be **extensible** and will grow over time with
additional animated elements and effects.

## ✨ Features

- 🎨 Animated UI elements for backgrounds and visual accents  
- 🛠 Fully configurable (colors, speed, direction, blur, behavior)  
- 🌈 Built-in color presets provided as reusable `[Color]` arrays  
- ⚡ Smooth, SwiftUI-native animations  
- 📱 Works everywhere in SwiftUI views

## 🛠️ Requirements

- iOS 17.0 or later
- macOS 14.0 or later
- Xcode 15 or later
- Swift 5.9 or later

## 📦 Installation (Swift Package Manager)

In Xcode:\
**File → Add Packages →** enter the repository URL:

    https://github.com/CodeByAlper/ADAnimatedUI

Or add to `Package.swift`:

``` swift
.package(url: "https://github.com/CodeByAlper/ADAnimatedUI", from: "1.0.0")
```

## 🚀 Usage

### Angular View 

``` swift
import ADAnimatedUI

struct ContentView: View {
    var body: some View {
        AnimatedAngularBackground(center: .center, speed: 1, autoreversed: true, blurRadius: 10)
            .ignoresSafeArea()
    }
}
```

<details>
<summary>more examples:</summary>

### Example: Face

``` swift 
import ADAnimatedUI

struct ContentView: View {
   var eyes: some View {
        HStack(spacing: 40) {
            ADAngularView(colors: ADColorPreset.rainbow.colors, speed: 1, blurRadius: 5)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 4, x: 10, y: 10)

            ADAngularView(colors: ADColorPreset.space.colors, speed: 5, reverse: true, blurRadius: 5)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(radius: 4, x: 10, y: 10)
        }
    }
    
    var mouth: some View {
        ZStack(alignment: .top) {
            ADAngularView(colors: ADColorPreset.forest.colors, speed: 1, blurRadius: 5)
                .frame(width: 350, height: 150)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(bottomLeading: 100, bottomTrailing: 100)
                    )
                )
                .shadow(radius: 4, x: 10, y: 10)

            // teeth
            HStack(spacing: 50) {
                ForEach(0..<3) { _ in
                    ADAngularView(colors: [.white, .gray], center: .top, speed: 10, autoreversed: true, blurRadius: 5)
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            ADAngularView(center: .topLeading, speed: 5, reverse: true, autoreversed: true, blurRadius: 0)
                .ignoresSafeArea()

            VStack(spacing: 80) {
                eyes
                mouth
            }
        }
    }
}
```
</details>

## 📚 Color Presets

| Name      | Colors                                                        |
| :-------- | :------------------------------------------------------------ |
| rainbow   | red, orange, yellow, green, blue, purple, pink, red           |
| forest    | green, brown, mint, green                                     |
| fire      | red, orange, yellow, red                                      |
| waterfall | teal, blue, teal (opacity: 0.8), cyan, blue                   |
| space     | purple, blue, indigo, cyan                                    |

## 🤝 Contribution

Contributions are welcome! 
1. Open an Issue\
2. Create a Pull Request\
3. Use clear and meaningful commit messages\
4. Keep PRs focused and concise

## 📄 License

MIT License -- free for personal and commercial projects.
