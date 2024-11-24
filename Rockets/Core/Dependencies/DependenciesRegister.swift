//
//  DependenciesRegister.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

class DependenciesRegister {
    
    /// Static method to register all the dependencies into the `DependencyContainer`
    static func registerDependencies(container: DependencyContainer) {
        
        /// NetworkServiceProtocol
        container.register(NetworkServiceProtocol.self,
                           instance: NetworkService())
        
        /// RocketsServicesProtocol
        let networkService = container.resolve(NetworkServiceProtocol.self)
        container.register(RocketsServicesProtocol.self,
                           instance: RocketsServices(networkService: networkService))
        
        /// FiltersManagerProtocol
        container.register(FilterLaunchesUseCaseProtocol.self,
                           instance: FilterLaunchesUseCase())
        
        /// GetImageFromUrlUseCaseProtocol
        container.register(GetImageFromUrlUseCaseProtocol.self,
                           instance: GetImageFromUrlUseCase(networkService: networkService))
        
        /// GetRocketsDataUseCaseProtocol
        let rocketsService = container.resolve(RocketsServicesProtocol.self)
        container.register(GetRocketsDataUseCaseProtocol.self,
                           instance: GetRocketsDataUseCase(rocketsServices: rocketsService))
        
        /// Example of a factory closure register
//        container.register(RocketsServicesProtocol.self) {
//            let networkService = DependencyContainer.shared.resolve(NetworkServiceProtocol.self)
//            let rocketsServices = RocketsServices(networkService: networkService)
//            return rocketsServices
//        }
    }
    
}
