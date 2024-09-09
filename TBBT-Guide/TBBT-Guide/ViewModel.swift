//
//  ViewModel.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 22/8/24.
//

import Foundation

enum Seasons: Int, CaseIterable, Identifiable {
    var id: Self {self}
    case todas
    case Primera = 1
    case Segunda
    case Tercera
    case Cuarta
    case Quinta
    case Sexta
    case Septima
    case Octava
    case Novena
    case Decima
    case Undecima
    case Duodecima
}


final class EpisodesListViewModel: ObservableObject {
    let episodesInteractor: EpisodeListInteractor
    
    @Published var allEpisodes: [Episode] = []
    
    var seasonEpisodes: [Episode] {
        allEpisodes.filter { episode in
            if season != .todas {
                return episode.season == season.rawValue
            } else {
                return true
            }
        }
    }
    
    
    @Published var season: Seasons = .Segunda
    
    init(episodesInteractor: EpisodeListInteractor = .shared) {
        self.episodesInteractor = episodesInteractor
        getEpisodes()
    }
    
    func getEpisodes() {
        do {
            self.allEpisodes = try episodesInteractor.loadEpisodes()
        } catch {
            print(error)
        }
    }
    
    
    func watchedToggle(episode: Episode) {
        print(episode.isFavorited)
        if let index = allEpisodes.firstIndex(of: episode) {
            allEpisodes[index].watched.toggle()
            print(allEpisodes[index])
        }
    }
    
    
}
