import Foundation
import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! I’m your Heretic-inspired AI assistant. Ask me anything.", isUser: false)
    ]
    @Published var inputText: String = ""
    @Published var isSending: Bool = false
    @Published var errorMessage: String? = nil

    private let chatService = ChatService()
    private let conversationID = "ios-demo"

    func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = ChatMessage(text: trimmed, isUser: true)
        messages.append(userMessage)
        inputText = ""
        isSending = true
        errorMessage = nil

        Task {
            do {
                let response = try await chatService.send(message: trimmed, conversationID: conversationID)
                let reply = ChatMessage(text: response.reply, isUser: false)
                messages.append(reply)
            } catch let error as ChatServiceError {
                let fallback = ChatMessage(
                    text: "The server could not respond. Please make sure the backend is running on port 8000.",
                    isUser: false
                )
                messages.append(fallback)
                errorMessage = String(describing: error)
            } catch {
                let fallback = ChatMessage(text: "Something went wrong.", isUser: false)
                messages.append(fallback)
                errorMessage = error.localizedDescription
            }

            isSending = false
        }
    }
}
