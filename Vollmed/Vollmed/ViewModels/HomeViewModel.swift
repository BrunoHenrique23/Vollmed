//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 11/08/25.
//

import Foundation


struct HomeViewModel {
    
    // MARK: - Attibutes
    let service: HomeServiceable
    let authService: AuthenticationServiceable
    var authManager = AuthenticationManager.shared
    
    //MARK - Init
    init(service: HomeServiceable, authService: AuthenticationServiceable) {
        self.service = service
        self.authService = authService
    }

    
    // MARK: - Class methods
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        switch result {
            
        case .success(let specialists):
            return specialists
            
        case .failure(let error):
            print(error)
            throw error
        }
    }
    
    func logout() async {
       let result = await authService.logout()
        switch result {
        case .success:
            authManager.removeToken()
            authManager.removePatientId()
        case .failure(let error):
            print("Erro ao tentar realizar o logout:  \(error.localizedDescription)")
        }
    }
}
