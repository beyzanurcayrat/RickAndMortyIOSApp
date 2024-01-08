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
    
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    /// - request: Request instance
    /// - completion:  Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void){ //closure olusturduk
        
    }
    
    
}





