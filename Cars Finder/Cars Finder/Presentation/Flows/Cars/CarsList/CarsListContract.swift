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
}

protocol CarsListViewModelOutput: AnyObject {
    var screenTitle: String { get }
    var error: String? { get }
    var cars: [Car] { get }
    
//    var fromCurrency: Currency? { get }
//    var fromCurrencyPublisher: AnyRelay<Currency?> { get }
//    var toCurrency: Currency? { get }
//    var toCurrencyPublisher: AnyRelay<Currency?> { get }
//    var convertedValuePublisher: AnyRelay<String?> { get }
    var errorPublisher: AnyRelay<String?> { get }
    var carsPublisher: AnyRelay<[Car]> { get }
    var isLoadingPublisher: AnyRelay<Bool> { get }
//    var supportedCurrencies: [Currency] { get }
//    var supportedCurrenciesPublisher: AnyRelay<[Currency]> { get }
//    var isConversionActivePublisher: AnyRelay<Bool> { get }
}

protocol CarsListOutput: AnyObject {
    
}
