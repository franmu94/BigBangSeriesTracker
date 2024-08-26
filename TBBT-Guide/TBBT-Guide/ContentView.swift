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
                    Text(episode.name)
                }
            }
            .toolbar {
                Button(action: {
                    showSeasons = true
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
                   
                    Picker("", selection: $vm.season) {
                        ForEach(Seasons.allCases) { season in
                            Text("Temporada \(season.rawValue)")
                        }
                    }
                Menu {
                    ForEach(Seasons.allCases) {season in
                        Text("\(season.rawValue)")
                        
                    }
                } label: {
                    Text("Temporadas")
                }
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
