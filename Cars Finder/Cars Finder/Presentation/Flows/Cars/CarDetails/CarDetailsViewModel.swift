//
//  CarDetailsViewModel.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

final class CarDetailsViewModel: CarDetailsViewModelProtocol {
    
    // MARK: Properties
    
    private let output: CarDetailsOutput
    private let appConfiguration: AppConfigurationProtocol
    
    // MARK: CarDetailsViewModelOutput
    
    let car: Car
    var currency: String { appConfiguration.currency }
    var distanceUnit: String { appConfiguration.distanceUnit }
    
    // MARK: Lifecycle
    
    init(output: CarDetailsOutput, configuration: CarDetailsConfiguration) {
        self.output = output
        self.car = configuration.car
        self.appConfiguration = configuration.appConfiguration
    }
}
