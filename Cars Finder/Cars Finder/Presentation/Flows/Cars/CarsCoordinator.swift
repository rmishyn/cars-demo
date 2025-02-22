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
            let configuration = CarsListConfiguration(getCarsUseCase: dependenciesResolver.resolve(GetCarsUseCaseProtocol.self)!,
                                                      appConfiguration: dependenciesResolver.resolve(AppConfigurationProtocol.self)!)
            let viewController = await CarsListViewBuilder().build(output: self, configuration: configuration)
            setToNavigationController(viewController: viewController, animated: false, completion: nil)
        }
    }
    
    func pushCarDetails(car: Car) {
        Task {
            let configuration = CarDetailsConfiguration(car: car,
                                                        appConfiguration: dependenciesResolver.resolve(AppConfigurationProtocol.self)!)
            let viewController = await CarDetailsViewBuilder().build(output: self, configuration: configuration)
            pushToNavigationController(viewController: viewController, animated: true)
        }
    }
}

// MARK: - CarsOutput

extension CarsCoordinator: CarsListOutput {
    
    func openCarDetails(car: Car) {
        pushCarDetails(car: car)
    }
}

// MARK: - CarDetailsOutput

extension CarsCoordinator: CarDetailsOutput {
    
}
