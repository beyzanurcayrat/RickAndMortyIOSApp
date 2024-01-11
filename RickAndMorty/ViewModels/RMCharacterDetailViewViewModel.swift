//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 11.01.2024.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    
    private let character: RMCharacter
    
    
    init(character: RMCharacter){
        self.character = character
        }
    
    
     var title: String{
        character.name.uppercased()
    }
    
}
