//
//  CarDetailsContract.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

typealias CarDetailsViewModelProtocol = CarDetailsViewModelInput & CarDetailsViewModelOutput

protocol CarDetailsViewModelInput: AnyObject {
    
}

protocol CarDetailsViewModelOutput: AnyObject {
    var car: Car { get }
    var currency: String { get }
    var distanceUnit: String { get }
}

protocol CarDetailsOutput: AnyObject {
    
}
