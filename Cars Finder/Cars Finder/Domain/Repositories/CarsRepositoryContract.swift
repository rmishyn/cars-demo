//
//  CarsRepositoryContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

protocol CarsRepositoryProtocol {
    func getCars() async throws -> [Car]
}
