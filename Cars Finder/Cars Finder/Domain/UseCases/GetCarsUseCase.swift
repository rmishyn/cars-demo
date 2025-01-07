//
//  GetCarsUseCase.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

protocol GetCarsUseCaseProtocol {
    func getCars() async -> GetCarsResponseValue
}

struct GetCarsRequestValue: Equatable {
    // This request doesn't require any parameters. This structure is used to conform general scheme
}

struct GetCarsResponseValue {
    let request: GetCarsRequestValue
    let result: Result<[Car], Error>
}

final class GetCarsUseCase: GetCarsUseCaseProtocol {
    
    private let repository: CarsRepositoryProtocol
    
    init(repository: CarsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCars(/*requestValue: GetCarsRequestValue*/) async -> GetCarsResponseValue {
        let requestValue = GetCarsRequestValue()
        do {
            let res = try await repository.getCars()
            return GetCarsResponseValue(request: requestValue, result: .success(res))
        } catch {
            return GetCarsResponseValue(request: requestValue, result: .failure(error))
        }
    }
}
