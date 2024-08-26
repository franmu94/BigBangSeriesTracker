//
//  SeasonsGrid.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 26/8/24.
//

import SwiftUI

struct SeasonsGrid: View {
    let adaptative: [GridItem] = [GridItem(.adaptive(minimum: 140))]
    @Binding var seasonChosed: Seasons
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptative, spacing: 30) {
                    ForEach(Seasons.allCases) { season in
                        VStack {
                            Image("season\(season.rawValue)")
                            Text("Temporada \(season.rawValue)")
                        }
                        .onTapGesture {
                            seasonChosed = season
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SeasonsGrid(seasonChosed: .constant(.Cuarta))
}
