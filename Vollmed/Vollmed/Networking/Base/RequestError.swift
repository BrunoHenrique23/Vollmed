//
//  RequestError.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 25/08/25.
//

import Foundation


enum RequestError: Error {
    
    case invalidURL
    case decode
    case noResponse
    case unknown
    case unauthorized
    case custom(error: [String: Any]?)
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de decodificação"
        case .unauthorized:
            return "unauthorized"
        case .unknown:
            return "erro desconhecido"
        case .invalidURL:
            return "url inválida"
        case .custom(let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                
                return message
            }
            return "Ops algo errado aconteceu. Tente novamente."
        case .noResponse:
            return "sem resposta do servidor"
        default:
            return "erro desconhecido"
        }
    }
}


