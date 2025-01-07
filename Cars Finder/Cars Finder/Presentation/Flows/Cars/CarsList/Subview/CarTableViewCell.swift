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
    
    func configure(with car: Car) {
        carImageView.sd_setImage(with: car.images?.first?.url.urlValue,
                                 placeholderImage: .transparentIcon) { image, error, _, url in
            print("Image for url='\(String(describing: url))': \(image?.size ?? .zero), error='\(String(describing: error))'")
        }
        infoLabel.text = [car.make, car.model, car.modelline]
            .compactMap({ $0 })
            .joined(separator: " ")
        priceLabel.text = "€\(car.price.formatted())"
        firstRegistrationLabel.text = [car.firstRegistration, "\(car.mileage.stringValue) km"]
            .compactMap({ $0 })
            .joined(separator: " - ")
        fuelLabel.text = "Fuel: \(car.fuel)"
        colorLabel.isHidden = car.colour == nil
        if let color = car.colour {
            colorLabel.text = "Color: \(color)"
        }
    }
}
