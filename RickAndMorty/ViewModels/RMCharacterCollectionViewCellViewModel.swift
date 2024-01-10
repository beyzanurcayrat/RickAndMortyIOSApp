//
//  RMCharactersCollectionListViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 11.01.2024.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {

    var characterName: String
    private let charactarStatusText: RMCharacterStatus
    private let characterImageUrl: URL?
    
    //MARK: - Init
    
    
    init(
        characterName: String,
        charactarStatusText: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.charactarStatusText = charactarStatusText
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return charactarStatusText.rawValue
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void){
        // TODO: Abstract to image manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest (url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
