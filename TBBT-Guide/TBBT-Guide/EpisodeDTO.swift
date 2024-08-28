//
//  EpisodeDTO.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation

struct EpisodeDTO: Codable {
    let id: Int
    let url: URL
    let name: String
    let season, number: Int
    let airdate: String
    let runtime: Int
    let image: String
    let summary: String
    
    func toEpisode() -> Episode {
        Episode(id: id,
                url: url,
                name: name,
                season: season,
                number: number,
                airdate: airdate,
                runtime: runtime,
                image: image,
                summary: summary,
                isFavorited: false,
                watched: false,
                protagonist: obtenerProtagonista(from: summary))
    }
    
    func obtenerProtagonista(from summary: String) -> String {
        let protagonistas = ["Leonard", "Sheldon", "Howard", "Raj", "Penny", "Bernadette", "Amy"]
        
        var contadorProtagonistas: [String: Int] = [:]
        
        // Inicializa el contador de cada protagonista en 0
        for protagonista in protagonistas {
            contadorProtagonistas[protagonista] = 0
        }
        
        // Recorre el resumen y cuenta cuántas veces aparece cada protagonista
        for protagonista in protagonistas {
            let count = summary.components(separatedBy: protagonista).count - 1
            contadorProtagonistas[protagonista]! += count
        }
        
        // Encuentra el número máximo de menciones
        let maxCount = contadorProtagonistas.values.max()
        
        // Filtra los protagonistas que tienen el conteo máximo
        let protagonistasPrincipales = contadorProtagonistas.filter { $0.value == maxCount }.map { $0.key }
        
        // Si hay más de un protagonista con el máximo conteo, devolvemos "multiple"
        if protagonistasPrincipales.count > 1 {
            return "multiple"
        } else {
            // Si no hay empate, devolvemos el protagonista principal
            return protagonistasPrincipales.first ?? "multiple"
        }
    }
}
