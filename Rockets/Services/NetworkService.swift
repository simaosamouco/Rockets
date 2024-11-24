//
//  Network.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw RocketsErros.fecthingDataFailed
        }
    }
    
    /// This commented out code was used when developing the app with no internet access.
    /// It also explains the `Resources` folder containg the JSONs from the API responses.
//    func fetchData(from url: URL) async throws -> Data {
//        
//        if try! url ==  Endpoints.getLaunches.url() {
//            let jsonData = Bundle.main.url(forResource: "RocketsJSON", withExtension: "json")!
//            return try! Data(contentsOf: jsonData)
//        }
//        
//        if try! url ==  Endpoints.getCompanyInfo.url() {
//            let jsonData = Bundle.main.url(forResource: "CompanyInfoJSON", withExtension: "json")!
//            return try! Data(contentsOf: jsonData)
//        }
//        return Data()
//    }
    
}
