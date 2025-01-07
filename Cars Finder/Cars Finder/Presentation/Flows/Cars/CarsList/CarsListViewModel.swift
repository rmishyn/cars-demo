//
//  CarsListViewModel.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

final class CarsListViewModel: CarsListViewModelProtocol {
    
    // MARK: Properties
    
    private let output: CarsListOutput
    private let appConfiguration: AppConfigurationProtocol
    
    // MARK: UseCases
    
    private let getCarsUseCase: GetCarsUseCaseProtocol
    
    // MARK: CarsListViewModelOutput
    
    let screenTitle: String = "Cars"
    lazy var currency: String = appConfiguration.currency
    lazy var distanceUnit: String = appConfiguration.distanceUnit
    @Published private(set) var error: String? = nil
    @Published private(set) var cars: [Car] = []
    @Published private var isLoading: Bool = false
    
    // MARK: Lifecycle
    
    init(output: CarsListOutput, configuration: CarsListConfiguration) {
        self.output = output
        self.getCarsUseCase = configuration.getCarsUseCase
        self.appConfiguration = configuration.appConfiguration
    }
}

// MARK: - CarsListViewModelOutput

extension CarsListViewModel {
    var errorPublisher: AnyRelay<String?> { $error.eraseToAnyPublisher() }
    var carsPublisher: AnyRelay<[Car]> { $cars.eraseToAnyPublisher() }
    var isLoadingPublisher: AnyRelay<Bool> { $isLoading.eraseToAnyPublisher() }
}

// MARK: - CarsListViewModelInput

extension CarsListViewModel {
    
    func viewDidLoad() {
        refresh()
    }
    
    func refresh() {
        Task {
            await fetchCars()
        }
    }
    
    func carPressed(at index: Int) {
        let car = cars[index]
        output.openCarDetails(car: car)
    }
}

// MARK: - Private methods

private extension CarsListViewModel {
    
    func fetchCars() async {
        isLoading = true
        defer {
            isLoading = false
        }
        let response = await getCarsUseCase.getCars()
        switch response.result {
        case .success(let cars):
            self.cars = cars
        case .failure:
            error = "Failed"
            error = nil
        }
    }
}
