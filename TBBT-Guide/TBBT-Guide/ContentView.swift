//
//  ContentView.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = EpisodesListViewModel()
    @State var showSeasons: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.seasonEpisodes, id: \.self) { episode in
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
            .toolbar {
                Button(action: {
                    showSeasons = true
                }, label: {
                    Text("Temporada")
                })
                
            }
            .sheet(isPresented: $showSeasons, content: {
                SeasonsGrid(seasonChosed: $vm.season)
            })
        }
    }
}

#Preview {
    ContentView()
}
