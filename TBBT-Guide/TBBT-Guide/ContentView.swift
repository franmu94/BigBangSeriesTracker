//
//  ContentView.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(EpisodesListViewModel.self) var vm
    @State var showSeasons: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.filteredEpisodes, id: \.self) { episode in
                    NavigationLink(value: episode){
                        EpisodeCell(episode: episode)
                            .swipeActions (edge: .leading){
                                Button {
                                    vm.watchedToggle(episode: episode)
                                } label: {
                                    Image(systemName: episode.watched ? "eye.slash" : "eye" )
                                        .tint(episode.watched ? .gray : .blue)
                                }
                            }
                    }
                }
            }
            //.listStyle(.inset)
            .navigationDestination(for: Episode.self, destination: { episode in
                EpisodeDeatil(episode: episode)
            })
            .toolbar {
                Button(action: {
                    showSeasons = true
                }, label: {
                    Text("Temporada")
                })
            }
            .sheet(isPresented: $showSeasons, content: {
                SeasonsGrid()
            })
        }
    }
}

#Preview {
    ContentView()
        .environment(EpisodesListViewModel())
}
