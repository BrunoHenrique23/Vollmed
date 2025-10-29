//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 26/08/25.
//

import Foundation



protocol HomeServiceable {
    
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}

struct HomeNetworkingService: HTTPClient, HomeServiceable {
    
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return try await sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }

}
