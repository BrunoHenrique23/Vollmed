//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 26/08/25.
//

import Foundation



enum HomeEndpoint {
    
    case getAllSpecialists
    
}

extension HomeEndpoint: Endpoint {
    
    var path: String {
        switch self {
            case .getAllSpecialists:
            return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self {
            case .getAllSpecialists:
            return .get
        }
    }
    var headers: [String : String]? {
        switch self {
            case .getAllSpecialists:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
    
 
}
