//
//  CarsAPIContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 08.01.2025.
//

import Foundation

protocol CarsAPIProtocol: API {
    func getCarsEndpoint() -> APIEndpoint
}
