//
//  RegistrationView.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 21/08/23.
//

import SwiftUI

struct RegistrationView: View {
    @State var nombreCompleto: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack (spacing:10){
            Text("¿Eres nuevo? Regístrate")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            Image("logo")
            VStack(spacing: 12){
                TextField("Nombre completo", text: $nombreCompleto)
                    .textContentType(.emailAddress)
                    .border(1, Color("figma").opacity(0.5))
                    .padding(.top, 25)
                TextField("Correo electrónico", text: $email)
                    .textContentType(.emailAddress)
                    .border(1, Color("figma").opacity(0.5))
                SecureField("Contraseña", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, Color("figma").opacity(0.5))
                
                Button{
                }label: {
                    Text ("Regístrate")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .fillView(Color("figma"))
                }
                .padding(15)
            }
            HStack{
                Text("¿Ya tienes cuenta?")
                    .foregroundColor(.gray)
                Button("Entra ahora"){
                }
                .foregroundColor(Color("figma"))
                
            }
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
