//
//  CarDetailsViewBuilder.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

struct CarDetailsConfiguration {
    let car: Car
    let appConfiguration: AppConfigurationProtocol
}

struct CarDetailsViewBuilder {
    
    typealias BuilderConfiguration = CarDetailsConfiguration
    typealias BuilderOutput = CarDetailsOutput
    typealias BuilderViewController = CarDetailsViewController
    typealias BuilderViewModel = CarDetailsViewModel
    
    func build(output: BuilderOutput, configuration: BuilderConfiguration) async -> BuilderViewController {
        let vc = await BuilderViewController.makeFromStoryboard { vc in
            let vc = vc as! BuilderViewController
            vc.viewModel = BuilderViewModel(output: output, configuration: configuration)
        }
        guard let vc else {
            fatalError("Can't build CarsListViewController")
        }
        return vc
    }
}
