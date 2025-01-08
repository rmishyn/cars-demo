//
//  Combine.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Combine

typealias CancelBag = Set<AnyCancellable>
typealias AnyRelay<Output> = AnyPublisher<Output, Never>
