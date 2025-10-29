//
//  ContentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authManager = AuthenticationManager.shared
    
    var body: some View {
       
        let _ = print("Token atual: '\(String(describing: authManager.token))'")
        let _ = print("Token isEmpty: \(authManager.token == nil)")
        
        if authManager.token == nil {
            NavigationStack {
                SigninView()
            }
        } else {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label(title: { Text("Home") }, icon: { Image(systemName: "house") })
                }
                
                NavigationStack {
                    MyAppointmentView()
                }
                .tabItem {
                    Label(title: { Text("Minhas Consultas") }, icon: { Image(systemName: "calendar") })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
