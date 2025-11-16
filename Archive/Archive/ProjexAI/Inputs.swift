import SwiftUI
import UIKit   // this is only for UIKeyboardType; optional but safe

struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.mutedText)

            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding()
                .background(Theme.textFieldBackground())
                .cornerRadius(12)
                .foregroundColor(Theme.whiteText)
        }
    }
}

struct CustomSecureField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundColor(Theme.mutedText)

            SecureField(placeholder, text: $text)
                .padding()
                .background(Theme.textFieldBackground())
                .cornerRadius(12)
                .foregroundColor(Theme.whiteText)
        }
    }
}
