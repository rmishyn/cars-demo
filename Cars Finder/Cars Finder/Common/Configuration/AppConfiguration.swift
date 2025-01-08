//
//  AppConfigurationContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

final class AppConfiguration: AppConfigurationProtocol {
    let apiBaseURL = URL(string: "https://private-fe87c-simpleclassifieds.apiary-mock.com")!
    let defaultAcceptType = HTTPContentType.json
    let defaultContentType = HTTPContentType.json
    let currency = "€"
    let distanceUnit = "km"
}
