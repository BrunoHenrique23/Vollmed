//
//  SkeletonCellView.swift
//  Vollmed
//
//  Created by Bruno Henrique Ferraz da Silva on 18/06/25.
//

import SwiftUI

struct SkeletonCellView: View {
        
    var body: some View {
        
        ForEach(0..<5, id: \.self) { _ in
            SkeletonCell()
        }
    }
}

struct SkeletonCell: View {
    
    let primaryColor = Color(.init(gray: 0.9, alpha: 1.0))
    let secondaryColor  = Color(.init(gray: 0.8, alpha: 1.0))
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            secondaryColor
                .frame(width: 116, height: 116)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 6) {
                primaryColor
                    .frame(height: 20)
                    .cornerRadius(10)
                
                primaryColor
                    .frame(height: 20)
                    .cornerRadius(10)
                
                secondaryColor
                    .frame(height: 20)
                    .cornerRadius(10)
                    .padding(.top, 35)
            }
         
        }
        .redectedAnimationModifier()
        .padding()
       
    }
}

#Preview {
    SkeletonCellView()
}
