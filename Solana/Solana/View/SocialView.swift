//
//  SocialView.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.
//

import SwiftUI

struct SocialView: View {
    var body: some View {
        TabView{
            PostsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Comunidad")
                }
            Chatbot()
                .tabItem {
                    Image(systemName: "message.circle")
                    Text("Chatbot")
                }
            InfoOne()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Información")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Mi perfil")
                }
            
        }.tint(Color("figma"))
        .navigationBarBackButtonHidden(true)
    }
}
        
    

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView()
    }
}
