//
//  URLRequestConvertible.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 08.01.2025.
//

import Foundation

public protocol URLRequestConvertible: Sendable {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}
