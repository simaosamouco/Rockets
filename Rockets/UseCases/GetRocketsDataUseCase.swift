//
//  GetRocketsDataUseCase.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 15/10/2024.
//

protocol GetRocketsDataUseCaseProtocol {
    func get() async throws -> ([Launch], CompanyInfo)
}

final class GetRocketsDataUseCase: GetRocketsDataUseCaseProtocol {
    
    private let rocketsServices: RocketsServicesProtocol
    
    init(rocketsServices: RocketsServicesProtocol) {
        self.rocketsServices = rocketsServices
    }
    
    func get() async throws -> ([Launch], CompanyInfo) {
        try await withThrowingTaskGroup(of: Void.self) { group in
            var launchesResult: [Launch] = []
            var companyInfoResult: CompanyInfo?

            group.addTask {
                launchesResult = try await self.rocketsServices.getRocketLaunches()
            }

            group.addTask {
                companyInfoResult = try await self.rocketsServices.getCompanyInfo()
            }

            try await group.waitForAll()

            guard let companyInfo = companyInfoResult else {
                throw RocketsErros.fecthingDataFailed
            }
            
            return (launchesResult, companyInfo)
        }
    }
    
}
