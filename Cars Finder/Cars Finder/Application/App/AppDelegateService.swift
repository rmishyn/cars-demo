//
//  AppDelegateService.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 06.01.2025.
//

import Foundation
import Swinject

final class AppDelegateService: AppDelegateServiceProtocol {
    
    // MARK: Properties
    
    
    private var diContainer: Container!
    var dependenciesResolver: Resolver { diContainer }
    
    // MARK: Lifecycle
    
    init() {
        setup()
    }
}

// MARK: - Private methods

private extension AppDelegateService {
    
    func setup() {
        setupDependencies()
    }
    
    func setupDependencies() {
        let diContainer = Container()
        diContainer.register(AppConfigurationProtocol.self) { _ in
            AppConfiguration()
        }
        diContainer.register(NetworkingServiceProtocol.self) { _ in
            NetworkingService()
        }
        diContainer.register(CarsAPIProtocol.self) { resolver in
            CarsAPI(appConfiguration: resolver.resolve(AppConfigurationProtocol.self)!)
        }
        diContainer.register(CarsAPIServiceProtocol.self) { resolver in
            CarsAPIService(carsAPI: resolver.resolve(CarsAPIProtocol.self)!,
                           networkingService: resolver.resolve(NetworkingServiceProtocol.self)!)
        }
        diContainer.register(CarsRepositoryProtocol.self) { resolver in
            CarsRepository(carsAPIService: resolver.resolve(CarsAPIServiceProtocol.self)!)
        }
        diContainer.register(GetCarsUseCaseProtocol.self) { resolver in
            GetCarsUseCase(repository: resolver.resolve(CarsRepositoryProtocol.self)!)
        }
        self.diContainer = diContainer
    }
}
