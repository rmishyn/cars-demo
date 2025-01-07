//
//  CarsCoordinator.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

protocol CarsCoordinatorOutput: AnyObject {
    
}

final class CarsCoordinator: AbstractCoordinator, Coordinator {
    
    enum Destination {
        case cars
    }
    
    // MARK: Properties
    
    private(set) weak var output: CarsCoordinatorOutput?
    
    // MARK: Lifecycle
    
    init(configuration: CoordinatorConfiguration<CarsCoordinatorOutput>, dependenciesResolver: Resolver) {
        self.output = configuration.output
        super.init(navigationController: configuration.navigationController, dependenciesResolver: dependenciesResolver)
    }
    
    deinit {
        
    }
    
    // MARK: Coordinator
    
    func start() {
        start(destination: .cars)
    }
    
    func start(destination: CarsCoordinator.Destination) {
        switch destination {
        case .cars:
            setCars()
        }
    }
}

// MARK: - Private methods

private extension CarsCoordinator {
    
    func setCars() {
        Task {
            let configuration = CarsListConfiguration(getCarsUseCase: dependenciesResolver.resolve(GetCarsUseCaseProtocol.self)!)
            let viewController = await CarsListViewBuilder().build(output: self, configuration: configuration)
            setToNavigationController(viewController: viewController, animated: false, completion: nil)
        }
    }
}

// MARK: - CarsOutput

extension CarsCoordinator: CarsListOutput {
    
}
