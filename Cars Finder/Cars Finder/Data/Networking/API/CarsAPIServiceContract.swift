//
//  CarsAPIServiceContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

protocol CarsAPIServiceProtocol {
    func getCars() async throws -> [CarDTO]
}
