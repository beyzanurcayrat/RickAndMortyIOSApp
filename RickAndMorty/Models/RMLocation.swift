//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 8.01.2024.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residants: [String]
    let url: String
    let created: String
}
