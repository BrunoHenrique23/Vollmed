//
//  Login.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 25/06/25.
//

import Foundation

struct LoginRequest: Codable {
    
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Codable, Identifiable {
    
    let auth: Bool
    let id: String
    let token: String
    
}
