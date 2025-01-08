//
//  UICollectionViewCell+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import UIKit

extension UICollectionViewCell {
    class func registerWithNib(for collectionView: UICollectionView) {
        let cellIdentifier = self.identifier
        collectionView.register(self, forCellWithReuseIdentifier: cellIdentifier)
        let cellNib = UINib(nibName: identifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
