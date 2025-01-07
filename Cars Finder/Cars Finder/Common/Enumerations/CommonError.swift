//
//  Error.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

/// List of error domains
enum ErrorDomain: String {
    case networking = "Networking"
}

enum CommonError: Error {
    case invalidResponseDataType
    case unknown(domain: ErrorDomain, statusCode: Int, details: String?)
    
    var details: String {
        switch self {
        case .invalidResponseDataType: "Response uses unexpected format"
        case .unknown(domain: let domain, statusCode: let code, details: let details): "Unknown (domain=\(domain.rawValue), code=\(code), details: \(details ?? "")"
        }
    }
}
