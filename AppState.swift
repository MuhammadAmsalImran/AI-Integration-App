import Foundation
import Combine

final class AppState: ObservableObject {

    // MARK: - Published App State
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User? = nil
    @Published var projects: [Project] = []
    @Published var chatMessages: [ChatMessage] = []

    // AI Service
    private let aiService = AIService()

    // MARK: - Init
    init() {
        seedSampleData()
    }

    // MARK: - Auth
    func signIn(email: String, password: String) {
        currentUser = User(
            name: "Urmi Popuri",
            email: email,
            university: "State University",
            isAdmin: false
        )
        isAuthenticated = true
    }

    func signUp(name: String, email: String, password: String, university: String) {
        currentUser = User(
            name: name,
            email: email,
            university: university,
            isAdmin: false
        )
        isAuthenticated = true
    }

    func toggleAdminMode() {
        guard var user = currentUser else { return }
        user.isAdmin.toggle()
        currentUser = user
        objectWillChange.send()
    }

    // MARK: - Projects
    func addProject(name: String, dueDate: Date, goal: String) {
        let newProject = Project(
            name: name,
            dueDate: dueDate,
            goal: goal,
            members: [currentUser?.name ?? "You"],
            tasks: []
        )
        projects.append(newProject)
    }

    // MARK: - Chat / AI
    func sendUserMessage(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Add user bubble
        chatMessages.append(ChatMessage(text: trimmed, isUser: true))

        // Call real AI (Gemini)
        aiService.generateTimeline(for: trimmed) { [weak self] (result: Result<String, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let replyText):
                    self?.chatMessages.append(
                        ChatMessage(text: replyText, isUser: false)
                    )
                case .failure:
                    self?.chatMessages.append(
                        ChatMessage(
                            text: "AI service error. Check your internet or API key.",
                            isUser: false
                        )
                    )
                }
            }
        }
    }

    // MARK: - Sample Data
    private func seedSampleData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let mobile = Project(
            name: "Mobile App Design",
            dueDate: formatter.date(from: "2025-10-25") ?? Date(),
            goal: "Design and build a mobile app UI.",
            members: ["Urmi Popuri", "Muhammad Amsal Imran"],
            tasks: [
                ProjectTask(
                    title: "Create wireframes",
                    dueDate: formatter.date(from: "2025-10-15") ?? Date()
                ),
                ProjectTask(
                    title: "Design mockups",
                    dueDate: formatter.date(from: "2025-10-20") ?? Date()
                )
            ]
        )

        let db = Project(
            name: "Database Project",
            dueDate: formatter.date(from: "2025-11-12") ?? Date(),
            goal: "Design a relational database and queries.",
            members: ["Team"],
            tasks: []
        )

        projects = [mobile, db]
    }
}
