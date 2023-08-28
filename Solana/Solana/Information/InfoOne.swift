//
//  InfoOne.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 28/08/23.
//

import SwiftUI

struct InfoOne: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Image("ImageInfo")
                    .resizable()
                NavigationLink(destination: EstrategiasAfrontamiento()) {
                    Text("Estrategias de Afrontamiento")
                        .font(.title2)
                        .padding()
                        .background(Color("figma"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: InformacionCancer()) {
                    Text("Información sobre Cáncer")
                        .font(.title2)
                        .padding()
                        .background(Color("figma"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
            .padding()
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Saber más", displayMode: .large)
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        InfoOne()
    }
}

