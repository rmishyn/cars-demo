//
//  CarsListBuilder.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

struct CarsListConfiguration {
    let getCarsUseCase: GetCarsUseCaseProtocol
}

struct CarsListViewBuilder {
    
    typealias BuilderConfiguration = CarsListConfiguration
    typealias BuilderOutput = CarsListOutput
    typealias BuilderViewController = CarsListViewController
    typealias BuilderViewModel = CarsListViewModel
    
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
