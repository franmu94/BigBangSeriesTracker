//
//  EpisodeListInteractor.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation

struct EpisodeListInteractor: JSONInteractorProtocol, URLInteractorProtocol {
    
    static let shared = EpisodeListInteractor()
    let urlInteractor: URLInteractorProtocol
    
    var bundleURL: URL
    var saveURL:URL
    init(urlInteractor: URLInteractorProtocol = URLProduction()) {
        self.urlInteractor = urlInteractor
        self.bundleURL = urlInteractor.bundleURL
        self.saveURL = urlInteractor.saveURL
    }
    
    func loadEpisodes() throws -> [Episode] {
        if FileManager.default.fileExists(atPath: saveURL.path()) {
            try getJSON(url: saveURL, type: [Episode].self)
        } else {
            try getJSON(url: bundleURL, type: [EpisodeDTO].self).map{ $0.toEpisode() }
        }
    }
    
    func saveEpisodes(episodes: [Episode]) throws {
        try writeJSON(file: saveURL.lastPathComponent, data: episodes)
    }
}
