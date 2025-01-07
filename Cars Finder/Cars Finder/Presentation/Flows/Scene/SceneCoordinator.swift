//
//  SceneCoordinator.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 06.01.2025.
//

import Foundation

protocol SceneCoordinatorOutput: AnyObject {
    
}

final class SceneCoordinator: AbstractCoordinator, Coordinator {
    
    enum Destination {
        case cars
    }
    
    // MARK: Properties
    
    private(set) weak var output: SceneCoordinatorOutput?
    
    // MARK: Lifecycle
    
    init(configuration: CoordinatorConfiguration<SceneCoordinatorOutput>, dependenciesResolver: Resolver) {
        self.output = configuration.output
        super.init(navigationController: configuration.navigationController, dependenciesResolver: dependenciesResolver)
    }
    
    deinit {
        
    }
    
    // MARK: Coordinator
    
    func start() {
        start(destination: .cars)
    }
    
    func start(destination: SceneCoordinator.Destination) {
        switch destination {
        case .cars:
            setCars()
        }
    }
}

// MARK: - Private methods

private extension SceneCoordinator {
    
    func setCars() {
        let configuration = CoordinatorConfiguration<CarsCoordinatorOutput>(navigationController: navigationController, output: self)
        let coordinator = CarsCoordinator(configuration: configuration, dependenciesResolver: dependenciesResolver)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

// MARK: - ConvertCoordinatorOutput

extension SceneCoordinator: CarsCoordinatorOutput {
    
}
