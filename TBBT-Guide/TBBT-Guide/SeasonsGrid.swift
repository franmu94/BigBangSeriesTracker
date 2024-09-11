//
//  SeasonsGrid.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 26/8/24.
//

import SwiftUI

struct SeasonsGrid: View {
    @Environment(EpisodesListViewModel.self) var vm

    let adaptative: [GridItem] = [GridItem(), GridItem()]
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptative, spacing: 30) {
                    ForEach(Seasons.allCases) { season in
                        VStack {
                            Image("season\(season.rawValue)")
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            Text(season != .todas ? "Temporada \(season.rawValue)" : "Todas")
                        }
                        .padding(8)
                        .background {
                            //Color(white: 0.75)
                            Color(vm.seasonsChoosed.contains(season) ? .blue.opacity(0.8) : .gray.opacity(0.4))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 5)
                        
                        
                        .onTapGesture {
                            vm.addSeason(season: season)
                        }
                    }
                }
                .toolbar {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Done")
                    })
                    
                }
            }
        }
    }
}

#Preview {
    SeasonsGrid()
        .environment(EpisodesListViewModel())
}
