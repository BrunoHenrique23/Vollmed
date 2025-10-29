//
//  Appointment.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 23/06/25.
//

import Foundation


struct Appointment: Identifiable, Codable {
    var id: String
    var date: String
    var specialist: Specialist
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}

