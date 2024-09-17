//
//  FavoriteGrid.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 17/9/24.
//

import SwiftUI

struct FavoriteGrid: View {
    @Environment(EpisodesListViewModel.self) var vm
    
    let adaptative: [GridItem] = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptative, spacing: 15) {
                    ForEach(vm.favoriteEpisodes, id: \.self) { episode in
                        NavigationLink(value: episode) {
                            FavoriteGridCell(episode: episode, size: 100)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDeatil(episode: episode)
            }
        }
    }
}

#Preview {
    FavoriteGrid()
        .environment(EpisodesListViewModel())
}
