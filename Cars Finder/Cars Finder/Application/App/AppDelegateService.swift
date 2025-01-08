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
        }.inObjectScope(.container)
        diContainer.register(NetworkingServiceProtocol.self) { _ in
            NetworkingService()
        }
        diContainer.register(CarsAPIProtocol.self) { resolver in
            guard let appConfiguration = resolver.resolve(AppConfigurationProtocol.self) else {
                fatalError("Cannot resolve AppConfigurationProtocol dependency")
            }
            return CarsAPI(appConfiguration: appConfiguration)
        }
        diContainer.register(CarsAPIServiceProtocol.self) { resolver in
            guard let carsAPI = resolver.resolve(CarsAPIProtocol.self) else {
                fatalError("Cannot resolve CarsAPIProtocol dependency")
            }
            guard let networkingService = resolver.resolve(NetworkingServiceProtocol.self) else {
                fatalError("Cannot resolve NetworkingServiceProtocol dependency")
            }
            return CarsAPIService(carsAPI: carsAPI, networkingService: networkingService)
        }
        diContainer.register(CarsRepositoryProtocol.self) { resolver in
            guard let carsAPIService = resolver.resolve(CarsAPIServiceProtocol.self) else {
                fatalError("Cannot resolve CarsAPIServiceProtocol dependency")
            }
            return CarsRepository(carsAPIService: carsAPIService)
        }
        diContainer.register(GetCarsUseCaseProtocol.self) { resolver in
            guard let repository = resolver.resolve(CarsRepositoryProtocol.self) else {
                fatalError("Cannot resolve CarsRepositoryProtocol dependency")
            }
            return GetCarsUseCase(repository: repository)
        }
        self.diContainer = diContainer
    }
}
