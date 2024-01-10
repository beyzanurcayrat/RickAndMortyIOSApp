//
//  Extensions.swift
//  RickAndMorty
//
//  Created by beyzanur cayrat on 10.01.2024.
//

import UIKit


extension   UIView {
    func addSubviews(_ views: UIView...){
        views.forEach {
            addSubview($0)
        }
        
    }
}
