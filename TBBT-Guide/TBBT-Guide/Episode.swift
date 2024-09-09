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
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    var isFavorited: Bool
    var watched: Bool 
    let protagonist: String
    var nota: Int {
        didSet {
            watched = true
            if nota >= 5 {
                isFavorited = true
            } else {
                isFavorited = false
            }
        }
    }
}
