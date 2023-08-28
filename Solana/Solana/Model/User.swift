//
//  User.swift
//  Solana
//
//  Created by Andrea Lima Blanca on 27/08/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var userNombreCompleto: String
    var userEmail: String
    var userGender: String
    var userAge: Int
    var userState: String
    var userUID: String
    var userProfileURL: URL
    var userBioLink: String
    
    enum CodingKeys: CodingKey{
        case id
        case userNombreCompleto
        case userEmail
        case userGender
        case userAge
        case userState
        case userUID
        case userProfileURL
        case userBioLink
    }
}


