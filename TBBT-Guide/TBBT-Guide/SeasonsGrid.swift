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
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptative, spacing: 30) {
                    ForEach(Seasons.allCases) { season in
                        VStack {
                            Image("season\(season.rawValue)")
                            Text(season != .todas ? "Temporada \(season.rawValue)" : "Todas")
                            
                        }
                        .padding(.top, season == .todas || season == .Primera ? 16 : 0)
                        
                        .onTapGesture {
                            seasonChosed = season
                            dismiss()
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
