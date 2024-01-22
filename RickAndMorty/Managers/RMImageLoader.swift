//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 17.01.2024.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    ///
    
    public func dowloadImage(_ url: URL, completion: @escaping (Result <Data, Error>) -> Void){
        
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key){
//            print("Reading form cache: \(key)")
            completion(.success(data as Data)) //NSData == Data | NSString == String
            return
        }
        let request = URLRequest (url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
        
    }
}
