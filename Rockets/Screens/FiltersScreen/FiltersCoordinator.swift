//
//  FiltersCoordinator.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import UIKit

protocol FiltersCoordinatorProtocol: Coordinator {
    func dismissFilters()
}

final class FiltersCoordinator: FiltersCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func dismissFilters() {
        dismiss()
    }
    
}
