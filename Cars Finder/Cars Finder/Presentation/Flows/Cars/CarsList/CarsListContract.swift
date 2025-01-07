//
//  CarsListContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Combine
import Foundation

typealias CarsListViewModelProtocol = CarsListViewModelInput & CarsListViewModelOutput

protocol CarsListViewModelInput: AnyObject {
    func viewDidLoad()
    func refresh()
    func carPressed(at index: Int)
}

protocol CarsListViewModelOutput: AnyObject {
    var screenTitle: String { get }
    var error: String? { get }
    var cars: [Car] { get }
    var currency: String { get }
    var distanceUnit: String { get }
    
    var errorPublisher: AnyRelay<String?> { get }
    var carsPublisher: AnyRelay<[Car]> { get }
    var isLoadingPublisher: AnyRelay<Bool> { get }
}

protocol CarsListOutput: AnyObject {
    func openCarDetails(car: Car)
}
