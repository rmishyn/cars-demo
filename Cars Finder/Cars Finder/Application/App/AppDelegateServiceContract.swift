//
//  AppDelegateServiceContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 06.01.2025.
//

import Foundation
import Swinject

typealias Resolver = Swinject.Resolver

protocol AppDelegateServiceProtocol {
    var dependenciesResolver: Resolver {get}
}
