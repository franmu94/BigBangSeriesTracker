//
//  ViewModel.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 22/8/24.
//

import Foundation

enum Seasons: Int, CaseIterable, Identifiable {
    var id: Self {self}
    
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
    
    var seasonEpisodes: [Episode]  = []
    @Published var season: Seasons = .Primera {
        didSet{
            episodesFromSeason(season.rawValue)
        }
    }
    
    init(episodesInteractor: EpisodeListInteractor = .shared) {
        self.episodesInteractor = episodesInteractor
        getEpisodes()
        episodesFromSeason(1)
    }
    
    func getEpisodes() {
        do {
            self.allEpisodes = try episodesInteractor.loadEpisodes()
        } catch {
            print(error)
        }
    }
    
    func episodesFromSeason(_ season: Int) {
        seasonEpisodes = allEpisodes.filter { $0.season == season}
    }
}
