//
//  ReusableProfileContent.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.
//
import SwiftUI
import SDWebImageSwiftUI

struct ReusableProfileContent: View {
    @State private var fetchedPosts: [Post] = []
    var user: User
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                HStack(spacing: 20) {
                    WebImage(url: user.userProfileURL)
                        .placeholder {
                            Image("NullProfile")
                                .resizable()
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user.userNombreCompleto)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        if let bioLink = URL(string: user.userBioLink) {
                            Link(user.userBioLink, destination: bioLink)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .underline()
                                .lineLimit(1)
                        }
                    }
                    .hAlign(.leading)
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                Text("Publicaciones")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                ReusablePostsView(basedOnUID: true, uid: user.userUID, posts: $fetchedPosts)
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .padding(10)
        }
    }
}
