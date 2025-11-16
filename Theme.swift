import SwiftUI

struct Theme {
    // Base colors
    static let background   = Color.black
    static let surface      = Color(red: 18/255, green: 18/255, blue: 22/255)
    static let surfaceAlt   = Color(red: 26/255, green: 26/255, blue: 32/255)

    static let gold         = Color(red: 212/255, green: 175/255, blue: 55/255)
    static let goldSoft     = Color(red: 230/255, green: 190/255, blue: 90/255)

    static let silver       = Color(red: 192/255, green: 192/255, blue: 192/255)
    static let silverSoft   = Color(red: 220/255, green: 220/255, blue: 220/255)

    static let whiteText    = Color.white
    static let mutedText    = Color(red: 150/255, green: 150/255, blue: 160/255)

    static let danger       = Color.red

    /// Background for all text fields / editors
    static func textFieldBackground() -> Color {
        surface   // 👈 dark, so white text is readable
    }

    static func cardGradient() -> LinearGradient {
        LinearGradient(
            colors: [surface, surfaceAlt],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
