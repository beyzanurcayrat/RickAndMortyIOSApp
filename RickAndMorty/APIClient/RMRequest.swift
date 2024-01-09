//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 8.01.2024.
//

import Foundation

/// Object That Represent a singlet API call.
final class RMRequest{

    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint:  RMEndpoint
    
    
    /// Path components for API, if any
    private let pathComponents: Set<String>
    
    /// Query Arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
        private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        
        if !pathComponents.isEmpty{
            string += "/"
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
    
        if !queryParameters.isEmpty{
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name) = \(value)"
            }).joined(separator: "&")
        }
        return string
    }
    
    
    /// Computed & Construccted API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Desire htttp method
    public let httpMethod = "GET"
    
    
    //MARK: - Public
    
    /// Construct request
    /// -Parameters:
    ///  -endpoint: Target endpoint
    ///  -pathComponent: Collection of path components
    ///  -queryParameters: Collection of query parameters
      public init(
        endpoint: RMEndpoint,
        pathComponents: Set<String> = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
    
    
    // https://rickandmortyapi.com/api/character/2
    
    
}
