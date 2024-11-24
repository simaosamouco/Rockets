//
//  DependencyContainer.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

class DependencyContainer {
    
    static let shared = DependencyContainer()

    private var services: [String: Any] = [:]

    private init() {}

    /// Register a factory closure for a type
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        services[key] = factory
    }

    /// Register a concrete instance for a type
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        services[key] = instance
    }

    /// Resolve a service for a certain type
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)

        /// Check for a registered instance
        if let service = services[key] as? T {
            return service
        }

        /// Check for a factory closure
        if let factory = services[key] as? () -> T {
            return factory()
        }

        fatalError("Could not resolve dependency.")
    }
    
}

