//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 8.01.2024.
//

import Foundation

///  Represents unique API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info
    case character //"character"
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}


