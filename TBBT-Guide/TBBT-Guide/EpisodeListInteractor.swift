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
    
    init(urlInteractor: URLInteractorProtocol = URLProduction()) {
        self.urlInteractor = urlInteractor
        self.bundleURL = urlInteractor.bundleURL
    }
    
    func loadEpisodes() throws -> [Episode] {
        try getJSON(url: bundleURL, type: [Episode].self)
    }
}
