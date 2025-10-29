//
//  Date+.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 18/06/25.
//

import Foundation


extension Date {
    
   func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.string(from: self)
    }
    
    
    
}
