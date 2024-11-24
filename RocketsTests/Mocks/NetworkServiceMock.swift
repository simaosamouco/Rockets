//
//  NetworkServiceMock.swift
//  RocketsTests
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import Foundation
@testable import Rockets

class NetworkServiceMock: NetworkServiceProtocol {
    
    var mockData: Data?
    var shouldThrowError: Bool = false
    var errorToThrow: Error = RocketsErros.fecthingDataFailed
    
    func fetchData(from url: URL) async throws -> Data {
        if shouldThrowError {
            throw errorToThrow
        }
        
        if let data = mockData {
            return data
        } else {
            throw RocketsErros.fecthingDataFailed
        }
    }
    
}
