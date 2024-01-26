//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 23.01.2024.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    
    public let type: `Type`
    
    public let value: String
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None"}
        return value
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            
                switch self {
                case .status:
                    return .systemBlue
                case .gender:
                    return .systemRed

                case .type:
                    return .systemPurple

                case .species:
                    return .systemGreen

                case .origin:
                    return .systemOrange

                case .created:
                    return .systemPink

                case .location:
                    return .systemYellow

                case .episodeCount:
                    return .systemMint

                }

        }
        
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")

            case .type:
                return UIImage(systemName: "bell")

            case .species:
                return UIImage(systemName: "bell")

            case .origin:
                return UIImage(systemName: "bell")

            case .created:
                return UIImage(systemName: "bell")

            case .location:
                return UIImage(systemName: "bell")

            case .episodeCount:
                return UIImage(systemName: "bell")

            }
        }
        var displayTitle: String{

            switch self {
            case .status:
                return "Something"
            case .gender:
                return "Something"

            case .type:
                return "Something"

            case .species:
                return "Something"

            case .origin:
                return "Something"

            case .created:
                return "Something"

            case .location:
                return "Something"

            case .episodeCount:
                return "Something"

            }
        }
        
    }
    
    init(
        type: `Type`, value: String
    
    ){
        self.value = value
        self.type = type
    }
    
}
