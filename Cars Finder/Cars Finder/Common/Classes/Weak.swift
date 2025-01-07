//
//  Weak.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 06.01.2025.
//

import Foundation

/// Weak object holding non-weak object
final class Weak<T: AnyObject> {
    /// Holded value
    weak var value : T?
    /**
     Initializer
     - Parameter value: Value to be held
     */
    init (value: T) {
        self.value = value
    }
}
