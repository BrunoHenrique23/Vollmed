//
//  Patient.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 24/06/25.
//

import Foundation



struct Patient: Codable, Identifiable{
  
    let id: String?
    let cpf: String
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case cpf
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
    
     
    
}
