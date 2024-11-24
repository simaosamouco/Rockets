//
//  Factory+Registration.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 24/11/2024.
//

extension Factory {
    
    func registerDependencies() {
        
        /// NetworkServiceProtocol
        register(NetworkServiceProtocol.self,
                 instance: NetworkService())
        
        /// RocketsServicesProtocol
        let networkService = resolve(NetworkServiceProtocol.self)
        register(RocketsServicesProtocol.self,
                 instance: RocketsServices(networkService: networkService))
        
        /// FiltersManagerProtocol
        register(FilterLaunchesUseCaseProtocol.self,
                 instance: FilterLaunchesUseCase())
        
        /// GetImageFromUrlUseCaseProtocol
        register(GetImageFromUrlUseCaseProtocol.self,
                 instance: GetImageFromUrlUseCase(networkService: networkService))
        
        /// GetRocketsDataUseCaseProtocol
        let rocketsService = resolve(RocketsServicesProtocol.self)
        register(GetRocketsDataUseCaseProtocol.self,
                 instance: GetRocketsDataUseCase(rocketsServices: rocketsService))
        
        /// Example of a factory closure register
//        register(RocketsServicesProtocol.self) {
//            let networkService = self.resolve(NetworkServiceProtocol.self)
//            let rocketsServices = RocketsServices(networkService: networkService)
//            return rocketsServices
//        }
    }
    
}
