//
//  CarImageCollectionViewCell.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import SDWebImage
import UIKit

final class CarImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(with url: URL?) {
        imageView.sd_setImage(with: url, placeholderImage: .transparentIcon) { image, error, _, url in
            print("CarImageCollectionViewCell: Image for url='\(String(describing: url))': \(image?.size ?? .zero), error='\(String(describing: error))'")
        }
    }
}
