//
//  LaunchScreen.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 18/08/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive=false
    @State private var size=0.8
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Image("logo")
                        .font(.system(size: 100))
                    Text("Solana")
                        .font(.system(size:200))
                        .bold()
                        .foregroundColor(Color("pink"))
                    NavigationLink(destination:MenuPrincipal().navigationBarBackButtonHidden(true), isActive:$isActive, label:{EmptyView()})
                }
                .scaleEffect(size)
                .onAppear{
                    withAnimation(.easeIn(duration:1)){
                        self.size=0.9
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                    self.isActive=true
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}

