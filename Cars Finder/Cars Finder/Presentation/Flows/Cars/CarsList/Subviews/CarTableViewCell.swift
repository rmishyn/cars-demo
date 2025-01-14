//
//  CarTableViewCell.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import SDWebImage
import UIKit

final class CarTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var carImageView: UIImageView! {
        didSet {
            carImageView.layer.borderColor = UIColor.content.cgColor
        }
    }
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var firstRegistrationLabel: UILabel!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var fuelLabel: UILabel!
    
    // MARK: Public methods
    
    func configure(with car: Car, currency: String, distanceUnit: String) {
        carImageView.sd_setImage(with: car.images?.first?.url.urlValue,
                                 placeholderImage: .transparentIcon) { image, error, _, url in
            print("Image for url='\(String(describing: url))': \(image?.size ?? .zero), error='\(String(describing: error))'")
        }
        infoLabel.text = car.info
        priceLabel.text = "\(currency)\(car.price.formatted())"
        firstRegistrationLabel.text = [car.firstRegistration, "\(car.mileage.formatted()) \(distanceUnit)"]
            .compactMap({ $0 })
            .joined(separator: " - ")
        fuelLabel.text = "Fuel: \(car.fuel)"
        colorLabel.isHidden = car.colour == nil
        if let color = car.colour {
            colorLabel.text = "Color: \(color)"
        }
    }
}
