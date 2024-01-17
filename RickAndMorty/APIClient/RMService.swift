//
//  RMService.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 8.01.2024.
//

import Foundation

/// Primary API servoce obhect to get Rick and Morty

final class RMService{
    ///Shared singleton instance
    static let shared =  RMService()
    
   /// Privatized constructor
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetRequest
    }
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    /// - request: Request instance
    /// - type: The type of object expect to get back
    /// - completion:  Callback with data or error
    public func execute<T: Codable >(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        //closure olusturduk
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        print("API Call: \(request.url?.absoluteString ?? "")")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetRequest ))
                return
            }
            
                // Decode response
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
                
            }
        }
        task .resume()
}
    
  //MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request =  URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}





