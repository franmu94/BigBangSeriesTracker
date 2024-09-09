//
//  EpisodeDetail.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 28/8/24.
//

import SwiftUI

struct EpisodeDeatil: View {
    
    @State var episode: Episode
    @State private var showInfo = false
    @State private var showSumary = false

    
    var body: some View {
        Form {
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
                            //Spacer()
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
            
            Section {
                            
                            //.listRowBackground(Color.clear) // Evita el fondo de formulario
                        }
            VStack {
                HStack {
                    Section {
                        Button(action: {
                            episode.watched.toggle()
                            if !episode.watched {
                                episode.nota = 0
                            }
                            episode.nota = 0
                        }) {
                            Image( systemName: "eye" )
                                .resizable()
                                .frame(width: 60, height: 40)
                                .foregroundColor(episode.watched ? .blue.opacity(0.7) : .gray)
                        }
                    
                        .padding(.trailing, 100) // Padding en el botón
                        Button(action: {
                            episode.isFavorited.toggle()
                        }) {
                            Image( systemName: "heart.fill" )
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundColor(episode.isFavorited ? .red.opacity(0.7) : .gray)
                        }
                    }

                }
                SwiftUIView(nota: $episode.nota)

            }
            .listRowBackground(Color.clear) // Evita el fondo de formulario
            .buttonStyle(BorderlessButtonStyle())
            
        }
        .navigationTitle("1x01")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack{
        EpisodeDeatil(episode: .preview1)
    }
}
