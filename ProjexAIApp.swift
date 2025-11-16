import SwiftUI

@main
struct ProjexAIApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .preferredColorScheme(.dark)   // force dark theme for black / gold UI
        }
    }
}

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            if appState.isAuthenticated {
                MainTabView()      // bottom tabs: Home / Projects / Chat / Profile
            } else {
                SignInView()       // login screen
            }
        }
    }
}
