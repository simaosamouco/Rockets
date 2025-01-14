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

final class RocketsCoordinator: RocketsCoordinatorProtocol {
    
    private let coreCoordinator: CoreCoordinatorProtocol
    private let factory: FactoryViewControllersProtocol
    
    /// Keeping a reference of an abstraction of the `FiltersViewController` to preserve the filters state.
    /// Saving a reference of a `UIViewController` to prevent coupling.
    /// There's no need for the Coordinator to know the concrete implementation of the Filters view.
    private var filtersViewController: UIViewController?
    
    init(coreCoordinator: CoreCoordinatorProtocol,
         factory: FactoryViewControllersProtocol) {
        self.coreCoordinator = coreCoordinator
        self.factory = factory
    }
    
    func presentFilters(launches: [Launch], delegate: FiltersDelegate) {
        if filtersViewController == nil {
            filtersViewController = factory.createFiltersViewController(launches: launches,
                                                                        filtersDelegate: delegate)
        }
        
        if let filtersVC = filtersViewController {
            coreCoordinator.presentScreen(filtersVC)
        }
    }
   
    func openWebview(_ url: URL) {
        coreCoordinator.openURL(url)
    }
    
    func showError(_ error: Error) {
        let message = (error as? RocketsErros)?.errorDescription ?? error.localizedDescription
        coreCoordinator.showAlert(title: "Something went wrong",
                                  message: message,
                                  actions: [UIAlertAction(title: "OK", style: .default)])
    }
    
}
