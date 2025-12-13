import SwiftUI

public enum ADColorPreset: CaseIterable {
    case rainbow, forest, fire, waterfall, space

    public var colors: [Color] {
        switch self {
            case .rainbow: return[.red, .orange, .yellow, .green, .blue, .purple, .pink, .red]
            case .forest: return [.green, .brown, .mint, .green]
            case .fire: return  [.red, .orange, .yellow, .red]
            case .waterfall: return [.teal, .blue, .teal.opacity(0.8), .cyan, .blue]
            case .space: return [.purple, .blue, .indigo, .cyan]
        }
    }
}
