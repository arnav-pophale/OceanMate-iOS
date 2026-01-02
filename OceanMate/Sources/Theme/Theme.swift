import SwiftUI

// Colors
extension Color {
    static let oceanNavy = Color(red: 10/255, green: 61/255, blue: 98/255)   // your chosen navy
    static let oceanInk  = Color(red: 6/255,  green: 22/255, blue: 36/255)
    static let oceanSky  = Color(red: 26/255, green: 91/255, blue: 135/255)
    static let oceanGlass = Color.white.opacity(0.08)
    static let oceanStroke = Color.white.opacity(0.18)
}

// Reusable “glass card” modifier
struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(14)
            .background(Color.oceanGlass)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.oceanStroke, lineWidth: 1)
            )
            .cornerRadius(14)
    }
}
extension View {
    func glassCard() -> some View { modifier(GlassCard()) }
}

// Primary button style
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.oceanNavy.opacity(configuration.isPressed ? 0.85 : 1))
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.98 : 1) // press effect
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { pressed in
                if pressed { Haptics.tap() } // light buzz on press
            }
    }
}


