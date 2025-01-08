//
//  CarsRepository.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

final class CarsRepository: CarsRepositoryProtocol {
    
    private let carsAPIService: CarsAPIServiceProtocol
    
    init(carsAPIService: CarsAPIServiceProtocol) {
        self.carsAPIService = carsAPIService
    }
    
    func getCars() async throws -> [Car] {
        try await carsAPIService.getCars()
    }
}
