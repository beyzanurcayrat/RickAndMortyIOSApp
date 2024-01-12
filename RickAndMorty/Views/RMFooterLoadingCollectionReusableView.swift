//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 12.01.2024.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(spinner)
        addConstraint()
    }
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
        
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
        spinner.widthAnchor.constraint(equalToConstant: 100),
        spinner.heightAnchor.constraint(equalToConstant: 100),
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    public func startAnimating(){
        spinner.startAnimating()
    }
    
}
