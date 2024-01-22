//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 11.01.2024.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    
    private let character: RMCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    
    //MARK: - Init
    init(character: RMCharacter){
        self.character = character
        }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    
     var title: String{
        character.name.uppercased()
    }
    
    public func fetchCharacterDta() {
        print(character.url)
        guard let url = requestUrl,
              let request = RMRequest(url: url) else {
            print("Failed to create")
            return
        }
        print(request.url)
    }
    
    

}
