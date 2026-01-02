import SwiftUI

struct ChatView: View {
    @State private var userMessage: String = ""
    @State private var chatResponse: String = ""
    @State private var isTyping: Bool = false

    private let openAI = OpenAIService()

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Chat Messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {

                    if !chatResponse.isEmpty {
                        Text("Assistant")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))

                        Text(chatResponse)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                    }

                    // Typing Indicator
                    if isTyping {
                        HStack(spacing: 8) {
                            ProgressView()
                                .tint(.white)

                            Text("Assistant is typing…")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, chatResponse.isEmpty ? 0 : 4)
                    }
                }
                .padding()
            }
            .foregroundStyle(.white)   // ✅ FIXES black scroll text
            .tint(.white)

            // MARK: - Input Bar
            HStack(spacing: 10) {
                ZStack(alignment: .leading) {
                    if userMessage.isEmpty {
                        Text("Ask something about fishing…")
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.leading, 12)
                    }

                    TextField("", text: $userMessage)
                        .padding(12)
                        .background(Color.white.opacity(0.08))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .disabled(isTyping)
                }

                Button {
                    askGPT()
                } label: {
                    Text(isTyping ? "Sending…" : "Send")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .opacity(isTyping ? 0.6 : 1.0)
                }
                .disabled(
                    isTyping ||
                    userMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                )
            }
            .padding()
            .background(Color.black.opacity(0.9))
        }
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Mock Chat Logic
    private func askGPT() {
        let text = userMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        isTyping = true
        userMessage = ""

        openAI.sendMessage(message: text) { response in
            chatResponse = response ?? "No response."
            isTyping = false
        }
    }
}
