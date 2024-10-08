//
//  URLInteractor.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation



protocol URLInteractorProtocol {
    var bundleURL: URL { get }
    var saveURL: URL { get }
}

struct URLProduction: URLInteractorProtocol {
    var bundleURL: URL {
        Bundle.main.url(forResource: "BigBang", withExtension: "json")!
    }
    var saveURL: URL {
        URL.documentsDirectory.appending(path: "savedEpisodes.json")
    }
}
