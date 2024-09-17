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
    
    var searchText: String = ""
    
    var filteredEpisodes: [Episode] {
        allEpisodes.filter {
            if !seasonsChoosed.contains(.todas) {
                seasonsChoosed.map { season in season.rawValue }.contains($0.season)
            } else {
                true
            }
        }
        .filter { searchText.isEmpty ? true : $0.name.contains(searchText)}
    }
    
    var favoriteEpisodes: [Episode] {
        allEpisodes
           // .filter { $0.isFavorited }
    }
    
    
    var seasonsChoosed: Set<Seasons> = [.todas]
    
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
    
    func searchEpisodes(searchText: String) -> [Episode] {
        filteredEpisodes.filter { searchText.isEmpty ? true : $0.name.contains(searchText)}
    }
    func giveSearch(text: String) {
        searchText = text
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
    
    func updateEpisode(episode: Episode) {
        if let index = allEpisodes.firstIndex(where: { $0.id == episode.id }) {
            allEpisodes[index] = episode
        }
    }
    
    func seasonWatched(as value: Bool = true) {
        searchText = ""
        filteredEpisodes.forEach { episode in
            let episodeWatched = Episode(id: episode.id,
                                         url: episode.url,
                                         name: episode.name,
                                         season: episode.season,
                                         number: episode.number,
                                         tipicNumber: episode.tipicNumber,
                                         airdate: episode.airdate,
                                         runtime: episode.runtime,
                                         image: episode.image,
                                         summary: episode.summary,
                                         isFavorited: episode.isFavorited,
                                         watched: value,
                                         protagonist: episode.protagonist,
                                         score: episode.score,
                                         notes: episode.notes)
            updateEpisode(episode: episodeWatched)
        }
    }
    
    func areSeasonsWatched() -> Bool {
        filteredEpisodes.allSatisfy { $0.watched }
    }
}
