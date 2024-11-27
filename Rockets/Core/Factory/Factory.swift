//
//  FactoryProtocol.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//


import UIKit

protocol FactoryProtocol {
    func createFactoryViewControllers() -> FactoryViewControllersProtocol
}

final class Factory: FactoryProtocol {
    
    var dependencies: [String: Any] = [:]
    
    init() {
        registerDependencies()
    }

    func createFactoryViewControllers() -> FactoryViewControllersProtocol {
        return FactoryViewControllers(dependenciesResolver: self)
    }
    
}
