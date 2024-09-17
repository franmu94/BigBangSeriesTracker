//
//  ejemplo2.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 11/9/24.
//

import SwiftUI

struct ejemplo2: View {
    @Environment(EpisodesListViewModel.self) var vm

    @State var episode: Episode
    @State private var showInfo = false
    @State private var showSumary = false
    
    @State private var stickyImage = false
    @State var showFirstImage = true
    @State private var scrollOffset: CGFloat = 0.0
    
    func calculateValue(scrollOffset: Double, minValue: Double) -> Double {
        // Limita scrollOffset entre 20 y 60
        let clampedOffset = max(20, min(60, scrollOffset))
        
        // Interpolación lineal
        let normalizedValue = (clampedOffset - 20) / (60 - 20) // Normalizamos entre 0 y 1
        
        // Ajustamos el valor a un rango de minValue a 1.0
        let result = minValue + normalizedValue * (1.0 - minValue)
        
        // Aseguramos los límites de salida
        return max(minValue, min(1.0, result))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Fondo del formulario
            if stickyImage {
                Image("12107")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIDevice.width * 0.8)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                //.transition(.opacity)
                    .animation(.easeInOut, value: stickyImage)
                    .opacity(calculateValue(scrollOffset: scrollOffset, minValue: 0.25)) // Ajustar opacidad según el scroll
                .blur(radius: 1)
            }
            Form {
                Section{
                    
                    // Imagen que se va a pegar arriba
                    GeometryReader { geo in
                        Image("12107")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIDevice.width * 0.8)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                            .opacity(showFirstImage ? 1.0 : 0.0)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onAppear {
                                scrollOffset = geo.frame(in: .global).minY
                            }
                            .onChange(of: geo.frame(in: .global).minY) { newValue in
                                scrollOffset = newValue
                                if Int(scrollOffset) % 1 == 0{
                                    print(scrollOffset)
                                    print(UIDevice.height * 0.1)
                                }
                                if newValue <= UIDevice.height * 0.115 {
                                    stickyImage = true
                                    showFirstImage = false
                                } else {
                                    stickyImage = false
                                    showFirstImage = true
                                }
                            }
                        
                    }
                    .padding(0)
                    .frame(height: UIDevice.height * 0.20)
                }
                .listRowBackground(Color.clear)
                
                
                Section(header: Text("Title")) {
                    Text(episode.name)
                }
                .listRowBackground(Color(.gray).blur(radius: 3).opacity(0.7))


                
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
                .listRowBackground(Color(.gray).blur(radius: 3).opacity(0.7))


                Section(header:
                            HStack {
                    Text("Sumary")
                    Button(action: {
                        withAnimation {
                            showSumary.toggle()
                        }
                    }) {
                        Image(systemName: showSumary ? "chevron.up" : "chevron.down")
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
            .scrollContentBackground(.hidden)
            
            
            
        }
        .navigationTitle(episode.tipicNumber)
        .navigationBarTitleDisplayMode(.inline)

    }
}


#Preview {
    NavigationStack {
        ejemplo2(episode: .preview1)
            .environment(EpisodesListViewModel())
    }
}
