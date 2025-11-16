import Foundation

enum AIServiceError: Error {
    case invalidURL
    case invalidResponse
}

/// Service that talks to Google Gemini via REST API
final class AIService {

    // ⚠️ Don't hard-code real keys in production / GitHub.
    // Replace with your key locally and keep it out of version control.
    private let apiKey = "AIzaSyA9vspbr876-1ugZZ5TLs62mYJ9igo_Who"

    private struct GeminiResponse: Decodable {
        struct Candidate: Decodable {
            struct Content: Decodable {
                struct Part: Decodable {
                    let text: String?
                }
                let parts: [Part]
            }
            let content: Content
        }
        let candidates: [Candidate]
    }

    /// General AI response (used for essays, questions, planning, etc.)
    func generateTimeline(   // you can rename to `generateResponse` later if you want
        for prompt: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        // If key is not set, just return a local fallback
        if apiKey.starts(with: "YOUR_") || apiKey.isEmpty {
            let fallback = self.localFallbackResponse(for: prompt)
            completion(.success(fallback))
            return
        }

        guard let url = URL(
            string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(apiKey)"
        ) else {
            print("❌ [AIService] Invalid URL")
            completion(.failure(AIServiceError.invalidURL))
            return
        }

        // 🔑 New, general system prompt (no longer “only timelines”)
        let requestText =
        """
        You are ProjexAI, a helpful AI assistant inside a student productivity app.

        Rules:
        - Answer ONLY based on the user's request below.
        - If the user asks for ESSAY help:
            • Help with understanding the prompt, brainstorming, thesis, outline, and paragraph ideas.
            • You may suggest wording but avoid writing the entire essay word-for-word.
        - If the user asks about APPS / PROJECTS / CODING:
            • Then you may talk about project timelines, features, or technical steps.
        - Do NOT assume the user is always building an app or project.
        - Keep your response clear, organized, and student-friendly.

        User message:
        \(prompt)
        """

        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": requestText]
                    ]
                ]
            ]
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
            print("❌ [AIService] Failed to encode JSON body")
            completion(.failure(AIServiceError.invalidResponse))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                print("❌ [AIService] Network error: \(error.localizedDescription)")
                let fallback = self.localFallbackResponse(for: prompt)
                completion(.success(fallback))
                return
            }

            guard let data = data else {
                print("❌ [AIService] No data in response")
                let fallback = self.localFallbackResponse(for: prompt)
                completion(.success(fallback))
                return
            }

            // Debug: print raw JSON
            if let jsonString = String(data: data, encoding: .utf8) {
                print("🛰 [AIService] Raw response:\n\(jsonString)")
            }

            do {
                let decoded = try JSONDecoder().decode(GeminiResponse.self, from: data)
                guard
                    let firstCandidate = decoded.candidates.first,
                    let firstPart = firstCandidate.content.parts.first,
                    let text = firstPart.text,
                    !text.isEmpty
                else {
                    print("❌ [AIService] Could not find text in response")
                    let fallback = self.localFallbackResponse(for: prompt)
                    completion(.success(fallback))
                    return
                }

                completion(.success(text))
            } catch {
                print("❌ [AIService] JSON decode error: \(error)")
                let fallback = self.localFallbackResponse(for: prompt)
                completion(.success(fallback))
            }
        }

        task.resume()
    }

    // MARK: - Local fallback (so demo still works offline / no key)

    private func localFallbackResponse(for prompt: String) -> String {
        """
        Here’s a structured way to approach this:

        1. Read the task carefully and identify the goal in your own words.
        2. Write a quick outline with 3–5 main points you want to cover.
        3. Turn the outline into short paragraphs (one idea per paragraph).
        4. Add an introduction that clearly states your main point or thesis.
        5. Finish with a short conclusion that summarizes your key ideas.

        Original request:
        "\(prompt)"
        """
    }
}
