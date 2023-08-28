//
//  SwiftUIView.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 18/08/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.bottom, 30)
            
            TextField("Correo electrónico", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            
            Button(action: {
                // Perform login validation here
                if isValidLogin() {
                    // Navigate to the next screen or perform necessary action
                } else {
                    showAlert = true
                }
            }) {
                Text("Iniciar sesión")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Login"), message: Text("Please check your username and password"), dismissButton: .default(Text("OK")))
        }
    }
    
    func isValidLogin() -> Bool {
        // Implement your login validation logic here
        let validUsername = "yourUsername"
        let validPassword = "yourPassword"
        
        return username == validUsername && password == validPassword
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
