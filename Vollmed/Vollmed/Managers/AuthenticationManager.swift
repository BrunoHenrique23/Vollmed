//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 27/06/25.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()

    @Published var token: String?
    @Published var patientId: String?

    
    private init() {
        self.token = KeychainHelper.get(for: "app-vollmed-token")
        self.patientId = KeychainHelper.get(for: "app-vollmed-patient-id")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = token
        }
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = nil
        }
    }
    
    func savePatientId(id: String) {
        KeychainHelper.save(value: id, key: "app-vollmed-patient-id")
        DispatchQueue.main.async {
           self.patientId = id
        }
    }
    
    func removePatientId() {
        KeychainHelper.remove(for: "app-vollmed-patient-id")
        
        DispatchQueue.main.async {
            self.patientId = nil
        }
    }
    
}
