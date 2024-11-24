//
//  RocketsCoordinator.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

import UIKit

protocol RocketsCoordinatorProtocol {
    func presentFilters(launches: [Launch], delegate: FiltersDelegate)
    func openWebview(_ url: URL)
    func showError(_ error: Error)
}

final class RocketsCoordinator: RocketsCoordinatorProtocol, Coordinator {
    
    var navigationController: UINavigationController
    private let factory: FactoryViewControllersProtocol
    
    /// Keeping a reference of an abstraction of the `FiltersViewController` to preserve the filters state.
    /// Saving a reference of a `UIViewController` to prevent coupling.
    /// There's no need for the Coordinator to know the concrete implementation of the Filters view.
    private var filtersViewController: UIViewController?
    //private let coordinator: Coordinator
    
    init(navigationController: UINavigationController,
         factory: FactoryViewControllersProtocol) {
        self.navigationController = navigationController
        self.factory = factory
        //self.coordinator = coordinator
    }
    
    func presentFilters(launches: [Launch], delegate: FiltersDelegate) {
        if filtersViewController == nil {
            filtersViewController = factory.createFiltersViewController(launches: launches,
                                                                        filtersDelegate: delegate)
        }
        
        if let filtersVC = filtersViewController {
            presentScreen(filtersVC)
        }
    }
   
    func openWebview(_ url: URL) {
        openURL(url)
    }
    
    func showError(_ error: Error) {
        let message = (error as? RocketsErros)?.errorDescription ?? error.localizedDescription
        showAlert(title: "Something went wrong",
                  message: message,
                  actions: [UIAlertAction(title: "OK", style: .default)])
    }
    
}
