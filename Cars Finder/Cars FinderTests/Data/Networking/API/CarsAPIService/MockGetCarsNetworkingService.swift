//
//  MockGetCarsNetworkingService.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 08.01.2025.
//

import Foundation

final class MockGetCarsNetworkingService: NetworkingServiceProtocol {
    func performRequest<T>(_ request: any URLRequestConvertible, completion: ServerResponseCompletion<T>?) {
        guard T.self == Data.self else {
            completion?(.failure(TestsError.unexpectedDataType), nil)
            return
        }
        let bundle = Bundle(for: MockGetCarsNetworkingService.self)
        guard let url = bundle.url(forResource: "MockGetCarsResponse", withExtension: "json") else {
            completion?(.failure(TestsError.mockDataNotFound), nil)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let tData = data as! T /* 'T' is 'Data' as checked above*/
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                completion?(.success(tData), nil)
            })
        } catch {
            completion?(.failure(TestsError.mockDataLoadingFailed), nil)
        }
    }
}
