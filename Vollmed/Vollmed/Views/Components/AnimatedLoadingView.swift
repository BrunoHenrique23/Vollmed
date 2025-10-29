//
//  AnimatedLoadingView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 26/06/25.
//

import SwiftUI

struct AnimatedLoadingView: View {

    @State private var isLoading = 0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
          ForEach(0 ..< 5) { index in
          Circle()
            .frame(width: 20, height: 20)
            .scaleEffect(isLoading == index ? 1.5 : 1)
            .foregroundStyle(isLoading == index ? .white : .blue)
            .animation(.easeInOut(duration: 0.7), value: isLoading)
          }
        }
        .onReceive(timer){_ in
          isLoading = (isLoading + 1) % 5
        }
    }
}

#Preview {
    AnimatedLoadingView()
}
