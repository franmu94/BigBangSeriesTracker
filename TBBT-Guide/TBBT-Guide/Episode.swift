//
//  Episode.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation


struct Episode: Codable, Hashable {
    let id: Int
    let url: URL
    let name: String
    let season: Int
    let number: Int
    let tipicNumber: String
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    var isFavorited: Bool
    var watched: Bool 
    let protagonist: String
    var score: Int
    var notes: String?
}
