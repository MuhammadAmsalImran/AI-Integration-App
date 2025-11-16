import Foundation

struct User: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var university: String
    var isAdmin: Bool
}

struct ProjectTask: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
}

struct Project: Identifiable {
    let id = UUID()
    var name: String
    var dueDate: Date
    var goal: String        // what the project is about
    var members: [String]
    var tasks: [ProjectTask]
}

struct ChatMessage: Identifiable {
    let id = UUID()
    var text: String
    var isUser: Bool
    var date: Date = Date()
}
