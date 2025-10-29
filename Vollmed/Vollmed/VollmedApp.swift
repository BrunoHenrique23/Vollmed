//
//  VollmedApp.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

@main
struct VollmedApp: App {
    
    init() {
          AuthenticationManager.shared.removeToken()
          AuthenticationManager.shared.removePatientId()
      }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
