// ContentView.swift

import SwiftUI

struct Chatbot: View {
    @ObservedObject var chatModel = ChatModel()
    @State private var userMessage: String = ""

    var body: some View {
        VStack {
            // Título
            Text("Chatbot")
                .font(.largeTitle.bold())
                .padding()

            // Lista de mensajes
            ScrollView {
                ForEach(chatModel.messages.indices, id: \.self) { index in
                    let message = chatModel.messages[index]
                    MessageView(text: message.text, isUser: message.isUser)
                }
            }

            // Campo para escribir y enviar
            HStack {
                TextField("Escribe tu mensaje...", text: $userMessage)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Button(action: {
                    if !userMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        chatModel.sendMessage(userMessage)
                        userMessage = ""
                    }
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct MessageView: View {
    let text: String
    let isUser: Bool

    var body: some View {
        HStack {
            // Imagen de perfil para el chatbot
            if !isUser {
                Image("chatbotProfile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.trailing, 5)
            }

            Text(text)
                .padding(10)
                .background(isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isUser ? .white : .black)
                .cornerRadius(10)
            
            if isUser {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct Chatbot_Previews: PreviewProvider {
    static var previews: some View {
        Chatbot()
    }
}

