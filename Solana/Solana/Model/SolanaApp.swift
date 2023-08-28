//
//  SolanaApp.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 18/08/23.
//

import SwiftUI
import Firebase
@main
struct SolanaApp: App {
    
    init (){
        FirebaseApp.configure()
        
    }
    var body: some Scene {
        WindowGroup {
            LaunchScreen()
        }
    }
}
