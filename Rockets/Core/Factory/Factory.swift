//
//  FactoryProtocol.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//


import UIKit

protocol FactoryProtocol {
    func createRocketsViewController() -> UIViewController
    func createFiltersViewController(launches: [Launch],
                                     filtersDelegate: FiltersDelegate) -> UIViewController
}

/// Responsible for creating `View Controllers` with their necessary dependencies.
final class Factory: FactoryProtocol {
    
    var dependencies: [String: Any] = [:]
    
    let navigationController = UINavigationController()
    
    init() {
        registerDependencies()
    }
  
    func createRocketsViewController() -> UIViewController {
        let rocketsCoordinator = RocketsCoordinator(navigationController: navigationController,
                                                    factory: self)
        let getImageFromUrlUseCase = resolve(GetImageFromUrlUseCaseProtocol.self)
        let getRocketsDataUseCase = resolve(GetRocketsDataUseCaseProtocol.self)
        let rocketsViewModel = RocketsViewModel(coordinator: rocketsCoordinator,
                                                getRocketsDataUseCase: getRocketsDataUseCase,
                                                getImageFromUrlUseCase: getImageFromUrlUseCase)
        let rocketsViewController = RocketsViewController(viewModel: rocketsViewModel)
        return rocketsViewController
    }
    
    func createFiltersViewController(launches: [Launch], filtersDelegate: FiltersDelegate) -> UIViewController {
        let filtersCoordinator = FiltersCoordinator(navigationController: navigationController)
        let filtersManager = resolve(FilterLaunchesUseCaseProtocol.self)
        let filtersViewModel = FiltersViewModel(coordinator: filtersCoordinator,
                                                filterLaunchesUseCase: filtersManager,
                                                filtersDelegate: filtersDelegate,
                                                launches: launches)
        let filtersViewController = FiltersViewController(viewModel: filtersViewModel)
        return filtersViewController
    }

}

/// Usar o factory e dependecy container não faz muito sentido usar juntos
