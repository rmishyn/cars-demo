//
//  CarDTO.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

struct CarDTO: Codable {
    let id: Int
    let make: String
    let model: String
    let modelline: String?
    let fuel: String
    let colour: String?
    let price: Int
    let firstRegistration: String?
    let mileage: Int
    let images: [CarImageDTO]?
    let description: String
    let seller: CarSellerDTO?
}
