//
//  WalkthroughScreen.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 20/08/23.
//

import SwiftUI

struct WalkthroughScreen: View {
    @State private var navigateToNextScreen = false
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        NavigationView {
            ZStack{
                NavigationLink(
                    destination: SocialView().navigationBarBackButtonHidden(true),
                    isActive: $navigateToNextScreen,
                    label: { EmptyView()
                    })
                ZStack{
                    if currentPage == 1 {
                        ScreenView(image: "b1", title: "¿Qué es Solana?", detail: "", bgback: "Image3", medidas1: 340, medidas2: 400)
                            .transition(.scale)
                    }
                    
                    if currentPage == 2 {
                        ScreenView(image: "b2", title: "¿Qué es Solana?", detail: "", bgback: "Image2", medidas1: 300, medidas2:400)
                            .transition(.scale)
                    }
                    
                    if currentPage == 3 {
                        ScreenView(image: "b3", title: "¿Qué es Solana?", detail: "", bgback: "Image", medidas1: 300, medidas2: 300)
                            .transition(.scale)
                    } 
                }
                    .onAppear() {
                        self.currentPage = 1
                    }
            }
            .overlay(
                Button(action:{
                    withAnimation(.easeInOut){
                        if currentPage < 3 {
                            currentPage+=1
                        }
                        else{
                            navigateToNextScreen = true
                        }
                    }
                }, label:{
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(
                            ZStack{
                                Circle()
                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                
                                Circle()
                                    .trim(from:0, to:CGFloat(currentPage) / CGFloat(totalPages))
                                    .stroke(Color.white, lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                                
                            }
                                .padding(-5)
                        )
                    
                })
                ,alignment: .bottom
            )
        } .navigationBarBackButtonHidden(true)
    }
}

struct WalkthroughScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughScreen()
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgback: String
    var medidas1: CGFloat
    var medidas2: CGFloat
    @AppStorage ("currentPage") var currentPage = 1 
    @State private var navigateToMenuPrincipal = false
    var body: some View {
        
        VStack(spacing:20){
            
            HStack{
                if currentPage == 1 {
                    Text("Bienvenido a Solana")
                        .font(.title)
                        .fontWeight(.bold)
                } 
                else {
                    Button(action:{withAnimation(.easeInOut){
                        currentPage-=1
                        }
                    }, label:{
                        Image(systemName:"chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                Spacer()
                

            } .foregroundColor(.black)
                .padding()
            Spacer()

            Image(image)
                .resizable()
                .frame(width: medidas1, height: medidas2)
                .aspectRatio(contentMode: .fit)
                .padding(.top, -100)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, -25)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut scelerisque ante ac fringilla malesuada. In vehicula arcu sit amet ullamcorper pellentesque. Vivamus eget vehicula augue. Pellentesque id ante tincidunt, aliquet nisl ut, congue quam. Mauris rutrum leo id dignissim.")
                .kerning(1.0)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer(minLength: 50)
            
        }
        .background(RoundedRectangle(cornerRadius: 25.0)
            .fill(.ultraThinMaterial)
            .frame(width:375, height: 610))
        .background(Image(bgback)
            .resizable()
            .frame(width:750, height: 1000))
    }
}

var totalPages = 3


