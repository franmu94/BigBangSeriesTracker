//
//  EpisodeDetail.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 28/8/24.
//

import SwiftUI

struct EpisodeDeatil: View {
    @Environment(EpisodesListViewModel.self) var vm

    @State var episode: Episode
    @State private var showInfo = false
    @State private var showSumary = false
    
    
    var body: some View {
        Form {
            Section {
                Image(episode.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    //.padding()
                    
                    //.listRowBackground(Color.clear)
            }
            
            Section(header: Text("Title")) {
                Text(episode.name)
            }

            
            Section(header:
                        HStack {
                Text("Info")
                //Spacer()
                Button(action: {
                    withAnimation {
                        showInfo.toggle()
                    }
                }) {
                    Image(systemName: showInfo ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            ) {
                if showInfo {
                    LabeledContent("Aired", value: episode.airdate)
                    HStack {
                        LabeledContent("Season:", value: "\(episode.season)")
                        Spacer(minLength: 80)
                        LabeledContent("Episode:", value: "\(episode.number)")
                    }
                    LabeledContent("Duration:", value: "\(episode.runtime) min.")
                    LabeledContent("Protagonist:", value: "\(episode.protagonist)")
                }
            }
            Section(header:
                        HStack {
                Text("Sumary")
                Button(action: {
                    withAnimation {
                        showSumary.toggle()
                    }
                }) {
                    Image(systemName: showInfo ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            ) {
                if showSumary {
                    Text(episode.summary)
                        .foregroundStyle(.gray)
                }
            }
            HStack {
                Section {
                    Spacer()
                    Button(action: {
                        episode.watched.toggle()
                        if !episode.watched {
                            episode.score = 0
                        }
                        episode.score = 0
                        
                        vm.watchedToggle(episode: episode)
                        
                    }) {
                        Image( systemName: "eye" )
                            .resizable()
                            .frame(width: 60, height: 40)
                            .foregroundColor(episode.watched ? .blue.opacity(0.7) : .gray)
                    }
                    Spacer()
                    Spacer()
                    Button(action: {
                        episode.isFavorited.toggle()
                    }) {
                        Image( systemName: "heart.fill" )
                            .resizable()
                            .frame(width: 50, height: 40)
                            .foregroundColor(episode.isFavorited ? .red.opacity(0.7) : .gray)
                    }
                    Spacer()
                    
                }
            }
            .listRowBackground(Color.clear) // Evita el fondo de formulario
            .buttonStyle(BorderlessButtonStyle())
            Section(header: Text("Your review")) {
                StarsComponen(nota: $episode.score)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            
        }
        .navigationTitle(episode.tipicNumber)
        .navigationBarTitleDisplayMode(.inline)
        .background {
            Color(.red)
        }
        
    }
}

#Preview {
    NavigationStack{
        EpisodeDeatil(episode: .preview1)
            .environment(EpisodesListViewModel())
    }
}
