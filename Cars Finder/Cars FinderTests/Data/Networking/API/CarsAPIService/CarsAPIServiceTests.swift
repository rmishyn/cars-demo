//
//  CarsAPIServiceTests.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 08.01.2025.
//

import XCTest
import Swinject
@testable import Cars_Finder

final class CarsAPIServiceTests: XCTestCase {
    
    let container = Container()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        container.register(AppConfigurationProtocol.self) { resolver in
            AppConfiguration()
        }
        container.register(CarsAPIProtocol.self) { resolver in
            CarsAPI(appConfiguration: resolver.resolve(AppConfigurationProtocol.self)!)
        }
        container.register(NetworkingServiceProtocol.self) { resolver in
            MockGetCarsNetworkingService()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        container.removeAll()
    }
    
    func testGetCars() async throws {
        let carsAPI = try XCTUnwrap(container.resolve(CarsAPIProtocol.self))
        let networkingService = try XCTUnwrap(container.resolve(NetworkingServiceProtocol.self))
        let carsAPIService = CarsAPIService(carsAPI: carsAPI, networkingService: networkingService)
        var cars = try await carsAPIService.getCars()
        cars = try XCTUnwrap(cars)
        let expectedCount = 5
        let expectedInfo = ["BMW 316i", "Audi A8 quattro", "Audi A7", "Ford Mondeo", "Porsche 911"]
        
        XCTAssertEqual(cars.count, expectedCount)
        for idx in 0..<expectedCount {
            XCTAssertEqual(cars[idx].id, idx + 1)
            XCTAssertEqual(cars[idx].info, expectedInfo[idx])
        }
        
    }
}
