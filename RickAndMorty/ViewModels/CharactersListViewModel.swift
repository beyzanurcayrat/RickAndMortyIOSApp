//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 10.01.2024.
//

import UIKit


final class CharactersListViewModel: NSObject {
    func fetchCharacters(){
        RMService.shared.execute(.listCaharactersRequests, expecting: RMGetCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: " + String(model.info.pages))
                print("Page Result Count:" + String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharactersListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2

        return CGSize(width: width,
                      height: width * 1.5)
    }
        
}

