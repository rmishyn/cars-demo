//
//  CarsAPI.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation
import Alamofire

protocol CarsAPIProtocol: API {
    func getCarsEndpoint() -> APIEndpoint
}

final class CarsAPI: CarsAPIProtocol {
    
    // MARK: - Enumerataions
    
    // MARK: Path
    
    enum Path: APIPath {
        
        case getCars
        
        var path: String {
            let pathComponents: [String] = switch self {
            case .getCars: [] // endoint doesn't have path components, is equal to 'baseURL'
            }
            return pathComponents.joined(separator: "/")
        }
    }
    
    // MARK: Endpoint
    
    enum Endpoint: APIEndpoint {
        
        case getCars
        
        /// Endpoint relative path (to base url)
        var path: APIPath {
            switch self {
            case .getCars: Path.getCars
            }
        }
        
        /// HTTP method of request
        var method: HTTPMethod {
            switch self {
            case .getCars: .get
            }
        }
        
        /// Body parameters - to be serialized as JSON
        var parameters: Parameters? { nil }
        
        /// Data added to HTTP request body. Ignore `parameters` if `body` is not nil
        var body: Data? { nil }
        
        /// Define custom value of `Accept` HTTP request header parameter instead of default value
        var acceptType: HTTPContentType? { nil }
        
        /// Define custom value of `Content-Type` HTTP request header parameter instead of default value
        var contentType: HTTPContentType? { nil }
        
        /// Collection of properties (`[key:value]`) which should be added to URL string as parameters
        var query: Query? { nil }
        
        /// Indicate if authentication (session) token should be added to `URLRequest`
        var authorized: Bool { false }
    }
    
    // MARK: - Properties
    
    private let appConfiguration: AppConfigurationProtocol
    var baseURL: URL { appConfiguration.apiBaseURL }
    var defaultAcceptType: HTTPContentType { appConfiguration.defaultAcceptType }
    var defaultContentType: HTTPContentType { appConfiguration.defaultContentType }
    
    // MARK: - Lifecycle
    
    init(appConfiguration: AppConfigurationProtocol) {
        self.appConfiguration = appConfiguration
    }
    
    // MARK: - CarsAPIProtocol
    
    func getCarsEndpoint() -> APIEndpoint {
        CarsAPI.Endpoint.getCars
    }
}
