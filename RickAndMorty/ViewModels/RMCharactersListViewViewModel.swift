//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 10.01.2024.
//

import UIKit

protocol RMCharactersListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class RMCharactersListViewViewModel: NSObject {
    
    public weak var delegate: RMCharactersListViewViewModelDelegate?
    private var characters: [RMCharacter] = []{
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)

            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []

    
    
    public func fetchCharacters(){
        RMService.shared.execute(.listCaharactersRequests,
                                 expecting: RMGetCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier , for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2

        return CGSize(width: width,
                      height: width * 1.5)
    }
        
}

