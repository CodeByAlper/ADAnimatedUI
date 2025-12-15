//
//  AnimatedAngularBackground.swift
//  ADAnimatedUI
//
//  Created by Alper D on 11.12.25.
//

import SwiftUI

/// An animated background view that renders an `AngularGradient` with rotation and an optional blur effect.
///
/// - Parameters:
///   - colors: The array of colors used to construct the gradient.
///   - center: The center point of the angular gradient.
///   - speed: The rotation speed of the animation.
///   - reverse: If `true`, the gradient rotates counterclockwise.
///   - autoreversed: If `true`, the rotation animation automatically reverses direction.
///   - blurRadius: The radius of the applied blur effect.
public struct ADAngularView: View {
    private static let baseSpeed: Double = 5.0

    let colors: [Color]
    let center: UnitPoint
    let speed: Double
    let reverse: Bool
    let autoreversed: Bool
    let blurRadius: CGFloat
    
    @State private var angle: Angle = .degrees(0)
    
    private var animation: Animation {
        .linear(duration: Self.baseSpeed / max(abs(speed), 0.01))
        .repeatForever(autoreverses: autoreversed)
    }
    
    public init(
        colors: [Color]? = nil,
        center: UnitPoint = .center,
        speed: Double = 1.0,
        reverse: Bool = false,
        autoreversed: Bool = false,
        blurRadius: CGFloat = 0
    ) {
        self.colors = colors ?? ADColorPreset.allCases.randomElement()?.colors ?? [.white, .gray]
        self.center = center
        self.speed = speed
        self.reverse = reverse
        self.autoreversed = autoreversed
        self.blurRadius = blurRadius
    }

    public var body: some View {
        AngularGradient(
            gradient: Gradient(colors: colors),
            center: center,
            angle: angle
        )
        .blur(radius: blurRadius)
        .drawingGroup()
        .animation(animation, value: angle)
        .onAppear { angle = .degrees(360 * (reverse ? -1 : 1)) }
    }
}

// MARK: - PREVIEWS

#Preview("Background") {
    ADAngularView(speed: 5, reverse: true, autoreversed: false, blurRadius: 4)
        .ignoresSafeArea()
}

#Preview("Face") {
    let eyes: () -> some View = {
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

    let mouth: () -> some View = {
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

    return ZStack {
        ADAngularView(center: .topLeading, speed: 5, reverse: true, autoreversed: true, blurRadius: 0)
            .ignoresSafeArea()

        VStack(spacing: 80) {
            eyes()
            mouth()
        }
    }
}
