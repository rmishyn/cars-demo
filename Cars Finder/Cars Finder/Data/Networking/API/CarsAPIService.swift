//
//  CarsAPIService.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

final class CarsAPIService: CarsAPIServiceProtocol {
    
    private let carsAPI: CarsAPIProtocol
    private let networkingService: NetworkingServiceProtocol
    
    init(carsAPI: CarsAPIProtocol, networkingService: NetworkingServiceProtocol) {
        self.carsAPI = carsAPI
        self.networkingService = networkingService
    }
    
    func getCars() async throws -> [CarDTO] {
        
        let endpoint = carsAPI.getCarsEndpoint()
        do {
            let request = try carsAPI.request(endpoint: endpoint)
            let result = try await withCheckedThrowingContinuation { [weak self] continuation in
                guard let self = self else { return }
                let completion: ServerResponseCompletion<Data> = { (result,data) in
                    switch result {
                    case .success(let data):
                        do {
                            let cars = try JSONDecoder().decode([CarDTO].self, from: data)
                            continuation.resume(returning: cars)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                self.networkingService.performRequest(request, completion: completion)
            }
            return result
        } catch {
            throw error
        }
    }
}
