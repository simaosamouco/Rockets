//
//  FactoryProtocol.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//


import UIKit

protocol FactoryProtocol {
    func createRocketsViewController() -> UIViewController
    func createFiltersViewController(launches: [Launch], filtersDelegate: FiltersDelegate) -> UIViewController
}

/// Responsible for creating `View Controllers` with their necessary dependencies.
struct Factory: FactoryProtocol {
    
    let navigationController = UINavigationController()
  
    func createRocketsViewController() -> UIViewController {
        let rocketsCoordinator = RocketsCoordinator(navigationController: navigationController,
                                                    factory: self)
        let getImageFromUrlUseCase = DependencyContainer.shared.resolve(GetImageFromUrlUseCaseProtocol.self)
        let getRocketsDataUseCase = DependencyContainer.shared.resolve(GetRocketsDataUseCaseProtocol.self)
        let rocketsViewModel = RocketsViewModel(coordinator: rocketsCoordinator,
                                                getRocketsDataUseCase: getRocketsDataUseCase,
                                                getImageFromUrlUseCase: getImageFromUrlUseCase)
        let rocketsViewController = RocketsViewController(viewModel: rocketsViewModel)
        return rocketsViewController
    }
    
    func createFiltersViewController(launches: [Launch], filtersDelegate: FiltersDelegate) -> UIViewController {
        let filtersCoordinator = FiltersCoordinator(navigationController: navigationController)
        let filtersManager = DependencyContainer.shared.resolve(FilterLaunchesUseCaseProtocol.self)
        let filtersViewModel = FiltersViewModel(coordinator: filtersCoordinator,
                                                filterLaunchesUseCase: filtersManager,
                                                filtersDelegate: filtersDelegate,
                                                launches: launches)
        let filtersViewController = FiltersViewController(viewModel: filtersViewModel)
        return filtersViewController
    }

}

/// Usar o factory e dependecy container não faz muito sentido usar juntos
