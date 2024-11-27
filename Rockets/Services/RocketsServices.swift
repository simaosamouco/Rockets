//
//  RocketsServices.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

protocol RocketsServicesProtocol {
    func getRocketLaunches() async throws -> [Launch]
    func getCompanyInfo() async throws -> CompanyInfo
}

final class RocketsServices: RocketsServicesProtocol {
    
    let networkService: NetworkServiceProtocol
    
    private let decoder = JSONDecoder()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getRocketLaunches() async throws -> [Launch] {
        let launchesData = try await fetchData(from: Endpoints.getLaunches.url())
        return try decode([Launch].self, from: launchesData)
    }
    
    func getCompanyInfo() async throws -> CompanyInfo {
        let companyInfoData = try await fetchData(from: Endpoints.getCompanyInfo.url())
        return try decode(CompanyInfo.self, from: companyInfoData)
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        return try await networkService.fetchData(from: url)
    }
    
    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw RocketsErros.decodingFailed
        }
    }
    
}
