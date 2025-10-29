//
//  Endpoint.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 25/08/25.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}


extension Endpoint {
    
    var scheme: String {
       return "http"
    }
    
    var host: String {
        return "localhost"
    }
    
}
