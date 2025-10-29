//
//  String+.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 18/06/25.
//

import Foundation


extension String {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return dateFormatter.string(from: date)
    }
}
