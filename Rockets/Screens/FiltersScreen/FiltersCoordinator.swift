//
//  FiltersCoordinator.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import UIKit

protocol FiltersCoordinatorProtocol {
    func dismissFilters()
}

final class FiltersCoordinator: FiltersCoordinatorProtocol {
    
    private let coreCoordinator: CoreCoordinatorProtocol
    
    init(coreCoordinator: CoreCoordinatorProtocol) {
        self.coreCoordinator = coreCoordinator
    }
    
    func dismissFilters() {
        coreCoordinator.dismiss()
    }
    
}
