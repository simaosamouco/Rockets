//
//  Factory+ViewControllers.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 24/11/2024.
//

import UIKit

protocol FactoryViewControllersProtocol {
    var navigationController: UINavigationController { get }
    func createRocketsViewController() -> UIViewController
    func createFiltersViewController(launches: [Launch],
                                     filtersDelegate: FiltersDelegate) -> UIViewController
}

/// Responsible for creating `View Controllers` with their necessary dependencies.
struct FactoryViewControllers: FactoryViewControllersProtocol {
   
    let dependenciesResolver: DependenciesResolverProtocol
    
    let navigationController = UINavigationController()
    
    init(dependenciesResolver: DependenciesResolverProtocol) {
        self.dependenciesResolver = dependenciesResolver
    }
    
    func createRocketsViewController() -> UIViewController {
        let rocketsCoordinator = RocketsCoordinator(navigationController: navigationController,
                                                    factory: self)
        let getImageFromUrlUseCase = dependenciesResolver.resolve(GetImageFromUrlUseCaseProtocol.self)
        let getRocketsDataUseCase = dependenciesResolver.resolve(GetRocketsDataUseCaseProtocol.self)
        let rocketsViewModel = RocketsViewModel(coordinator: rocketsCoordinator,
                                                getRocketsDataUseCase: getRocketsDataUseCase,
                                                getImageFromUrlUseCase: getImageFromUrlUseCase)
        let rocketsViewController = RocketsViewController(viewModel: rocketsViewModel)
        return rocketsViewController
    }
    
    func createFiltersViewController(launches: [Launch], filtersDelegate: FiltersDelegate) -> UIViewController {
        let filtersCoordinator = FiltersCoordinator(navigationController: navigationController)
        let filtersManager = dependenciesResolver.resolve(FilterLaunchesUseCaseProtocol.self)
        let filtersViewModel = FiltersViewModel(coordinator: filtersCoordinator,
                                                filterLaunchesUseCase: filtersManager,
                                                filtersDelegate: filtersDelegate,
                                                launches: launches)
        let filtersViewController = FiltersViewController(viewModel: filtersViewModel)
        return filtersViewController
    }
    
}
