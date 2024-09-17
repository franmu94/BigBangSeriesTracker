//
//  FavoritegridCall.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 17/9/24.
//

import SwiftUI

struct FavoriteGridCell: View {
    
    @State var episode: Episode
    var size = 90.0
    
    var body: some View {
        VStack {
            //Text(episode.tipicNumber)
            Image(episode.image)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size*0.6)
                .overlay(alignment: .bottom)  {
                    Rectangle()
                        .fill(.white.opacity(0.5))
                        .frame(height: size * 0.2)
                        .overlay(alignment: .leading) {
                            Text(episode.tipicNumber)

                                .bold()
                                .padding(.leading)
                        }
                }
                .padding(0)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            StarsComponen(nota: $episode.score, size: size * 0.10)
                .allowsHitTesting(false)
        }
        .padding(8)
        .background {
            //Color(white: 0.75)
            Color(.gray.opacity(0.6))
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    FavoriteGridCell(episode: .preview1)
}
