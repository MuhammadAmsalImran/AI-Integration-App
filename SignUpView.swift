import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var university = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        // MARK: - Logo + Title
                        VStack(spacing: 16) {
                            Image("projexai_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 28))
                                .shadow(radius: 10)

                            Text("Create Account")
                                .font(.title.bold())
                                .foregroundColor(Theme.whiteText)

                            Text("Join ProjexAI to plan smarter")
                                .font(.subheadline)
                                .foregroundColor(Theme.mutedText)
                        }

                        // MARK: - Fields
                        VStack(spacing: 16) {
                            CustomTextField(
                                title: "Full Name",
                                placeholder: "Your name",
                                text: $fullName
                            )

                            CustomTextField(
                                title: "Email",
                                placeholder: "your.email@university.edu",
                                text: $email,
                                keyboardType: .emailAddress
                            )

                            CustomSecureField(
                                title: "Password",
                                placeholder: "Create a password",
                                text: $password
                            )

                            CustomTextField(
                                title: "University",
                                placeholder: "Your university name",
                                text: $university
                            )
                        }

                        // MARK: - Create Account Button
                        Button {
                            appState.signUp(
                                name: fullName,
                                email: email,
                                password: password,
                                university: university
                            )
                            dismiss()
                        } label: {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.gold)
                                .cornerRadius(14)
                        }

                        // MARK: - Sign In Link
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                            Button("Sign In") { dismiss() }
                                .foregroundColor(Theme.gold)
                        }
                        .font(.footnote)
                        .foregroundColor(Theme.mutedText)
                    }
                    .padding(24)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
