//
//  MenuPrincipal.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 20/08/23.
//

import SwiftUI

struct MenuPrincipal: View {
    var body: some View {
        NavigationView {
            VStack (spacing:10) {
                VStack (spacing:20) {
                    Image("logo")
                        .resizable()
                        .frame(width: 340, height: 350)
                        .padding(15)
                    Text("Bienvenido a Solana")
                        .font(.largeTitle.bold())
                    Text("Tu acompañante emocional")
                        .font(.title2)
                        .fontWeight(.medium)
                        .lineLimit(11)
                        .padding(.top, 0.0)
                        
                }
                .padding(15)
                NavigationLink(destination: RegistrationView().navigationBarBackButtonHidden(true)){
                    Text("Registrarse")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .background(Color("figma"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                .padding(15)
                
                NavigationLink(destination: LogInScreen()) {
                    Text("Iniciar Sesión")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding()
                        .background(Color("figma"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } .vAlign(.top)
                .padding(15)
        }
    }
}

struct MenuPrincipal_preview: PreviewProvider {
    static var previews: some View {
        MenuPrincipal()
    }
}


