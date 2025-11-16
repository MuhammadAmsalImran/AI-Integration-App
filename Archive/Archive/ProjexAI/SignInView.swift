import SwiftUI

struct SignInView: View {
    @EnvironmentObject var appState: AppState

    @State private var email = ""
    @State private var password = ""
    @State private var showSignUp = false

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // MARK: - Logo + Title
                VStack(spacing: 16) {
                    Image("projexai_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .shadow(radius: 12)

                    Text("Projex AI")
                        .font(.largeTitle.bold())
                        .foregroundColor(Theme.whiteText)

                    Text("Smart Project Planning")
                        .font(.subheadline)
                        .foregroundColor(Theme.mutedText)
                }

                // MARK: - Fields
                VStack(spacing: 16) {
                    CustomTextField(
                        title: "Email",
                        placeholder: "your.email@university.edu",
                        text: $email,
                        keyboardType: .emailAddress
                    )

                    CustomSecureField(
                        title: "Password",
                        placeholder: "Enter your password",
                        text: $password
                    )
                }

                // MARK: - Sign In Button
                Button(action: {
                    appState.signIn(email: email, password: password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.gold)
                        .cornerRadius(14)
                }
                .padding(.top, 8)

                // MARK: - Sign Up Link
                HStack(spacing: 4) {
                    Text("Don't have an account?")
                    Button("Sign Up") { showSignUp = true }
                        .foregroundColor(Theme.gold)
                }
                .font(.footnote)
                .foregroundColor(Theme.mutedText)

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .sheet(isPresented: $showSignUp) {
            SignUpView()
                .environmentObject(appState)
        }
    }
}
