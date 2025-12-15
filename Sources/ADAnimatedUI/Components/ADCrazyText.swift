//
//  ADCrazyText.swift
//  ADAnimatedUI
//
//  Created by Alper D on 13.12.25.
//

import SwiftUI

let alphabet: String = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz" +
                       "!@#$%€^&*?=()_+,./[]{}-<> "

/// An animated text view that cycles random characters until the target text is reached.
///
/// - Parameters:
///   - text: The final text the animation resolves to.
///   - speed: Controls the animation speed. Higher values are faster.
///   - autoStart: Starts the animation automatically when the view appears.
///   - trigger: A hashable value used to restart the animation.
public struct ADCrazyText: View {
    let text: String
    var speed: Double = 1.0
    var autoStart: Bool = true
    var trigger: AnyHashable = 0

    @State private var animatedText: String = ""
    @State private var hasStarted = false
    
    public var body: some View {
          Text(animatedText)
              .font(.largeTitle.bold())
              .monospaced()
              .task(id: trigger) {
                  animatedText = shuffe()
                  if autoStart || !autoStart && hasStarted {
                      await animate()
                  }
                  hasStarted = true
              }
              .onAppear {
                  hasStarted = autoStart
              }
      }

      @MainActor
      private func animate() async {
          let target = Array(text)

          while animatedText != text {
              animatedText = zip(animatedText, target).map { current, targetChar in
                  String(
                    current == targetChar
                          ? current
                          : nextChar(after: current)
                  )
              }.joined()

              try? await Task.sleep(
                  nanoseconds: UInt64(15_000_000 / max(speed, 0.01))
              )
          }
      }

      private func shuffe() -> String {
          String(text.map { _ in alphabet.randomElement()! })
      }

      private func nextChar(after char: Character) -> Character {
          guard let index = alphabet.firstIndex(of: char) else { return char }
          let next = alphabet.index(after: index)
          return next < alphabet.endIndex ? alphabet[next] : alphabet.first!
      }
  }


#Preview {
    @Previewable @State var trigger = 0

    VStack(spacing: 24) {
        ADCrazyText(text: "Hello, World!", speed: 2)
        ADCrazyText(text: "Hello, World!", autoStart: false, trigger: trigger)
        ADCrazyText(text: "Hello, World!", speed: 0.25, trigger: trigger)

        Button("Restart animation") {
            trigger += 1
        }
        .buttonStyle(.borderedProminent)
    }
    .padding()
}
