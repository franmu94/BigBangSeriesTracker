//
//  SwiftUIView.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 9/9/24.
//

import SwiftUI

struct StarsComponen: View {
    @Binding var nota: Int
    var body: some View {
        HStack {
            
            ForEach((1...5), id: \.self) { star in
                Button {
                    print(star)
                    nota = star
                } label: {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(nota >= star ? .yellow : .clear)
                        .overlay {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                                .opacity(0.75)
                        }
                }
            }
        }
    }
}

#Preview {
    StarsComponen(nota: .constant(0))
}
