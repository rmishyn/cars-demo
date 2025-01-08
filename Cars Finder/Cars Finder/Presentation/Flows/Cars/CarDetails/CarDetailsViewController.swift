//
//  CarDetailsViewController.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import UIKit

final class CarDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel: CarDetailsViewModelProtocol?
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var imagesContainerView: UIView!
    @IBOutlet private weak var imagesCollectionView: UICollectionView! {
        didSet {
            CarImageCollectionViewCell.registerWithNib(for: imagesCollectionView)
        }
    }
    @IBOutlet private weak var collectionViewAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet private weak var prevImageButton: UIButton!
    @IBOutlet private weak var nextImageButton: UIButton!
    
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var firstRegistrationLabel: UILabel!
    @IBOutlet private weak var mileageLabel: UILabel!
    @IBOutlet private weak var colorLabel: UILabel!
    @IBOutlet private weak var fuelLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sellerStackView: UIStackView!
    @IBOutlet private weak var sellerTypeLabel: UILabel!
    @IBOutlet private weak var sellerCityLabel: UILabel!
    @IBOutlet private weak var sellerPhoneButton: UIButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel else {
            fatalError("'viewModel' is not set in '\(Self.self)'")
        }
        setup(with: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateImagesNavigationAvailability()
    }
}

// MARK: - Private methods

private extension CarDetailsViewController {
    
    func setup(with viewModel: CarDetailsViewModelProtocol) {
        let car = viewModel.car
        imagesContainerView.isHidden = (car.images?.count ?? 0) == 0
        
        if let flowLayout = imagesCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIApplication.keyWindow?.bounds.width ?? view.bounds.width
            let height = width / collectionViewAspectRatioConstraint.multiplier
            flowLayout.itemSize = CGSize(width: width, height: height)
            imagesCollectionView?.collectionViewLayout = flowLayout
        }
        
        infoLabel.text = car.info
        priceLabel.text = "\(viewModel.currency)\(car.price.formatted())"
        firstRegistrationLabel.text = "First registration: \(car.firstRegistration ?? "")"
        mileageLabel.text = "Mileage: \(car.mileage.formatted()) \(viewModel.distanceUnit)"
        fuelLabel.text = "Fuel: \(car.fuel)"
        colorLabel.text = "Color: \(car.colour ?? "")"
        descriptionLabel.text = car.description
        
        colorLabel.isHidden = car.colour == nil
        firstRegistrationLabel.isHidden = car.firstRegistration == nil
        descriptionLabel.isHidden = car.description.isEmpty
        
        if let seller = car.seller {
            sellerStackView.isHidden = false
            sellerTypeLabel.text = "Type: \(seller.type)"
            sellerCityLabel.text = "City: \(seller.city)"
            sellerPhoneButton.setTitle(seller.phone, for: .normal)
            sellerPhoneButton.layer.borderColor = UIColor.content.cgColor
        } else {
            sellerStackView.isHidden = true
        }
    }
    
    func focusedIndex() -> Int {
        Int(round(imagesCollectionView.contentOffset.x / imagesCollectionView.frame.width))
    }
    
    func updateImagesNavigationAvailability() {
        let focusedIndex = focusedIndex()
        guard let images = viewModel?.car.images,
              images.count > 0 else {
            return
        }
        
        let isFirstItemVisible = focusedIndex == 0
        prevImageButton.isEnabled = !isFirstItemVisible
        prevImageButton.alpha = isFirstItemVisible ? 0.5 : 1
        
        let isLastItemVisible = focusedIndex == images.count - 1
        nextImageButton.isEnabled = !isLastItemVisible
        nextImageButton.alpha = isLastItemVisible ? 0.5 : 1
    }
}

// MARK: - Actions

private extension CarDetailsViewController {
    
    @IBAction func callToSellerPressed(_ sender: UIButton) {
        guard let phoneNumber = viewModel?.car.seller?.phone else { return }
        if let phoneNumberUrl = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(phoneNumberUrl) {
                UIApplication.shared.open(phoneNumberUrl)
            } else {
                showAlert(title: "Error", message: "Cannot call to seller")
            }
        } else {
            showAlert(title: "Error", message: "Cannot open phone number")
        }
    }
    
    @IBAction func goToPrevImagePressed(_ sender: UIButton) {
        let focusedIndex = focusedIndex()
        guard focusedIndex > 0 else {
            return
        }
        imagesCollectionView.scrollToItem(at: IndexPath(item: focusedIndex - 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func goToNextImagePressed(_ sender: UIButton) {
        let focusedIndex = focusedIndex()
        guard let imagesQty = viewModel?.car.images?.count,
              focusedIndex < imagesQty - 1 else {
            return
        }
        imagesCollectionView.scrollToItem(at: IndexPath(item: focusedIndex + 1, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CarDetailsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (section == 0) ? (viewModel?.car.images?.count ?? 0) : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarImageCollectionViewCell.identifier, for: indexPath) as! CarImageCollectionViewCell
        cell.configure(with: viewModel.car.images?[indexPath.row].url.urlValue)
        
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension CarDetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === imagesCollectionView {
            updateImagesNavigationAvailability()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView === imagesCollectionView {
            updateImagesNavigationAvailability()
        }
    }
}
