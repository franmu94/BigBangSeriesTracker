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

@Observable
final class EpisodesListViewModel {
    let episodesInteractor: EpisodeListInteractor
    
    var allEpisodes: [Episode] = [] {
        didSet {
            print("Se guarda")
           try? episodesInteractor.saveEpisodes(episodes: allEpisodes)
        }
    }
    
    var filteredEpisodes: [Episode] {
        allEpisodes.filter {
            if !seasonsChoosed.contains(.todas) {
                seasonsChoosed.map { season in season.rawValue }.contains($0.season)
            } else {
                true
            }
        }
    }
    
    
    var seasonsChoosed: Set<Seasons> = [.Primera]
    
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
        if let index = allEpisodes.firstIndex(of: episode) {
            allEpisodes[index].watched.toggle()
            print(allEpisodes[index])
        }
    }
    
    func favoritedToggle(episode: Episode) {
        if let index = allEpisodes.firstIndex(of: episode) {
            allEpisodes[index].isFavorited.toggle()
            print(allEpisodes[index])
        }
    }
    
    func addSeason(season: Seasons) {
        if season == .todas {
            seasonsChoosed = [.todas]
            return
        }
        if seasonsChoosed.contains(season) {
            seasonsChoosed.remove(season)
        } else {
            seasonsChoosed.remove(.todas)
            seasonsChoosed.insert(season)
        }
    }
}
