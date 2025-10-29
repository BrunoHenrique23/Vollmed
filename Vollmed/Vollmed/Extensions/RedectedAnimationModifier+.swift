//
//  RedectedAnimationModifier.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 29/10/25.
//


import SwiftUI

struct RedectedAnimationModifier: ViewModifier {
    
    @State private var isRedected: Bool = true
    
    func body(content: Content) -> some View {
        content
            .opacity(isRedected ? 0 : 1)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true)){
                    self.isRedected.toggle()
                }
            }
    }
}

extension View {
    func redectedAnimationModifier() -> some View {
        modifier(RedectedAnimationModifier())
    }
}



