//
//  AppConfiguration.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

protocol AppConfigurationProtocol {
    var apiBaseURL: URL {get}
    var defaultAcceptType: HTTPContentType {get}
    var defaultContentType: HTTPContentType {get}
}
