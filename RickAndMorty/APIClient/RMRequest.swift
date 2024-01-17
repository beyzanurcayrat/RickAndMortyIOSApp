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
    private let pathComponents: [String]
    
    /// Query Arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
        private var urlString: String {
            var string = Constants.baseUrl
            string += "/"
            string += endpoint.rawValue

            if !pathComponents.isEmpty {
                pathComponents.forEach({
                    string += "/\($0)"
                })
            }

            if !queryParameters.isEmpty {
                string += "?"
                let argumentString = queryParameters.compactMap({
                    guard let value = $0.value else { return nil }
                    return "\($0.name)=\(value)"
                }).joined(separator: "&")

                string += argumentString
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
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    

    /// Attempt to create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let rmEndpoint = RMEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                // value=name&value=name
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")

                    return URLQueryItem(
                        name: parts[0],
                        value: parts[1]
                    )
                })

                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }

        return nil
    }
}

extension RMRequest {
    static let listCaharactersRequests = RMRequest(endpoint: .character)
}

