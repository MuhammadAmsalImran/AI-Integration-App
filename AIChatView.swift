import SwiftUI

struct AIChatView: View {
    @EnvironmentObject var appState: AppState
    @State private var inputText = ""
    @State private var showQuick = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(appState.chatMessages) { msg in
                                    ChatBubble(message: msg)
                                }
                            }
                            .padding()
                        }
                        .onChange(of: appState.chatMessages.count) { _ in
                            if let last = appState.chatMessages.last {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }

                    HStack(spacing: 8) {
                        Button {
                            showQuick = true
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(Theme.gold)
                        }

                        TextField("Ask AI anything…", text: $inputText)
                            .padding(10)
                            .background(Theme.surface)
                            .cornerRadius(20)
                            .foregroundColor(Theme.whiteText)

                        Button {
                            let text = inputText
                            inputText = ""
                            appState.sendUserMessage(text)
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .padding(10)
                                .background(Theme.gold)
                                .foregroundColor(.black)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(Theme.surfaceAlt)
                }
            }
            .navigationTitle("AI Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showQuick) {
                QuickQuestionsView { question in
                    inputText = ""
                    appState.sendUserMessage(question)
                    showQuick = false
                }
                .environmentObject(appState)
            }
        }
    }
}

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer() }

            Text(message.text)
                .padding(12)
                .background(message.isUser ? Theme.gold : Theme.surface)
                .foregroundColor(message.isUser ? .black : Theme.whiteText)
                .cornerRadius(18)
                .frame(
                    maxWidth: UIScreen.main.bounds.width * 0.7,
                    alignment: message.isUser ? .trailing : .leading
                )

            if !message.isUser { Spacer() }
        }
        .id(message.id)
    }
}
