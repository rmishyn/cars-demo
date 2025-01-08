//
//  Publisher+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Combine
import Foundation

extension Publisher {
    
    /// Method is used for `receive(on: DispatchQueue.main)` shortening
    func onMain() -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: DispatchQueue.main)
    }
}
