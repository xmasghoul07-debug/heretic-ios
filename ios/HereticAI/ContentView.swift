import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                HStack {
                                    if message.isUser {
                                        Spacer()
                                    }

                                    Text(message.text)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 10)
                                        .foregroundStyle(message.isUser ? .white : .primary)
                                        .background(message.isUser ? .blue : Color(.secondarySystemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                                    if !message.isUser {
                                        Spacer()
                                    }
                                }
                                .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        if let last = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }

                HStack {
                    TextField("Message", text: $viewModel.inputText)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            viewModel.sendMessage()
                        }

                    Button(action: viewModel.sendMessage) {
                        if viewModel.isSending {
                            ProgressView()
                                .frame(width: 20, height: 20)
                        } else {
                            Text("Send")
                        }
                    }
                    .disabled(viewModel.isSending || viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
            }
            .navigationTitle("Heretic AI")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        viewModel.messages = [ChatMessage(text: "Hello! I’m your Heretic-inspired AI assistant. Ask me anything.", isUser: false)]
                        viewModel.errorMessage = nil
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
