//
//  SpinnerView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 17/06/25.
//

import SwiftUI

struct SpinnerView: View {
    var body: some View {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
          .scaleEffect(2.0, anchor: .center)
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

            }
          }
    }
}

#Preview {
    SpinnerView()
}
