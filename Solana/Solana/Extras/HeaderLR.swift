//
//  HeaderLR.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 21/08/23.
//

import SwiftUI

struct HeaderLR: View {
    var body: some View {
        ZStack{
            Image("logo")
                .resizable()
                .frame(width: 240, height: 250)
                .padding(.top, -350)
            Text("Tu acompañante emocional")
                .fontWeight(.semibold)
                .padding(.top, -80)
        }
    }
}

struct HeaderLR_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLR()
    }
}
