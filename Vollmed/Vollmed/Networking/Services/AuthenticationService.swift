//
//  AuthenticationService.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 26/08/25.
//

import Foundation


protocol AuthenticationServiceable {
    
    func logout() async -> Result<Bool?, RequestError>

    
}

struct AuthenticationService: HTTPClient, AuthenticationServiceable {
    
    func logout() async -> Result<Bool?, RequestError> {
        return try! await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
    
    
    
}
