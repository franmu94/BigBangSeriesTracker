//
//  ContentView.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import SwiftUI

struct EpisodeList: View {
    @Environment(EpisodesListViewModel.self) var vm
    @State var showSeasons: Bool = false
    @State var searchText: String = ""
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
            .listStyle(.inset)
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDeatil(episode: episode)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    if !vm.seasonsChoosed.contains(.todas) {
                        Button(action: {
                            vm.seasonWatched(as: !vm.areSeasonsWatched())
                        }, label: {
                            Text("Mark season\(vm.seasonsChoosed.count > 1 ? "s" : "") as \(vm.areSeasonsWatched() ? "un" : "")watched")
                        })
                    }
                }
                ToolbarItem (placement: .navigationBarTrailing){
                    Button(action: {
                        showSeasons = true
                    }, label: {
                        Text("Season")
                    })
                }
            }
            .navigationTitle("Episodes")
            .searchable(text: $searchText, prompt: "Episode name")
            .onChange(of: searchText) {
                vm.searchText = searchText
            }
            .sheet(isPresented: $showSeasons, content: {
                SeasonsGrid()
            })
        }
    }
}

#Preview {
    EpisodeList()
        .environment(EpisodesListViewModel())
}
