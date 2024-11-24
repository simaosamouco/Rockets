//
//  Factory+DependencyInjection.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 24/11/2024.
//

protocol DependencyInjectionProtocol {
    /// Register a factory closure for a type
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    
    /// Register a concrete instance for a type
    func register<T>(_ type: T.Type, instance: T)
    
    /// Resolve a service for a certain type
    func resolve<T>(_ type: T.Type) -> T
}

extension Factory: DependencyInjectionProtocol {
    
    /// Register a factory closure for a type
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
    }

    /// Register a concrete instance for a type
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        dependencies[key] = instance
    }

    /// Resolve a service for a certain type
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)

        /// Check for a registered instance
        if let service = dependencies[key] as? T {
            return service
        }

        /// Check for a factory closure
        if let factory = dependencies[key] as? () -> T {
            return factory()
        }

        fatalError("Could not resolve dependency.")
    }
    
}
