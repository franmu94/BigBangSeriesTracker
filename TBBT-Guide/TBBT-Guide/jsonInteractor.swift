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
}
