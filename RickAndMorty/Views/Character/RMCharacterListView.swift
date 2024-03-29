//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 10.01.2024.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(
        _ characterListView: RMCharacterListView,
        didSelectCharacter character: RMCharacter
    )
}


/// View that handles showing list of characters, loader, etc
final class RMCharacterListView: UIView {
    public weak var delegate: RMCharacterListViewDelegate?
    
    private let viewModel = RMCharactersListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
        
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.isHidden = true
        collectionView.alpha = 0 
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier:  RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self , forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier  )
        return collectionView
    }()
    
    
    
    //MARK: - Init
    
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView,spinner)
        addConstraint()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()


    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),

            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}


extension RMCharacterListView:  RMCharactersListViewViewModelDelegate {
    
    
    

    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self , didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
        self.spinner.stopAnimating()
        self.collectionView.isHidden = false
        collectionView.reloadData() //initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {

        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
        
    }
}
