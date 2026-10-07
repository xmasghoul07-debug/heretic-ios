import Foundation

enum ChatServiceError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case serverError(String)
}

final class ChatService {
    private let baseURL: URL

    init(baseURL: String = "http://127.0.0.1:8000") {
        self.baseURL = URL(string: baseURL) ?? URL(string: "http://127.0.0.1:8000")!
    }

    func send(message: String, conversationID: String = "demo") async throws -> ChatResponse {
        guard let url = URL(string: "/chat", relativeTo: baseURL) else {
            throw ChatServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: String] = [
            "message": message,
            "conversation_id": conversationID
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw ChatServiceError.requestFailed
        }

        guard 200..<300 ~= http.statusCode else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw ChatServiceError.serverError(body)
        }

        do {
            let decoded = try JSONDecoder().decode(ChatResponse.self, from: data)
            return decoded
        } catch {
            throw ChatServiceError.decodingFailed
        }
    }
}
