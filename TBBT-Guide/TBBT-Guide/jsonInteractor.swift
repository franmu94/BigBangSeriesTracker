//
//  jsonInteractor.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 21/8/24.
//

import Foundation

protocol JSONInteractorProtocol {
    func getJSON<JSON>(url: URL, type: JSON.Type ) throws -> JSON where JSON: Codable
}

extension JSONInteractorProtocol {
    func getJSON<JSON>(url: URL, type: JSON.Type ) throws -> JSON where JSON: Codable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
    
    func writeJSON<JSON>(file: String, data: JSON) throws where JSON: Codable {
        let url = URL.documentsDirectory.appending(path: file)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let encodedData = try encoder.encode(data)
        try encodedData.write(to: url, options: .atomic)
    }
}
