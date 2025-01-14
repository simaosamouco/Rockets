//
//  Factory+DependencyInjection.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 24/11/2024.
//

protocol DependenciesRegisterProtocol {
    /// Register a factory closure for a type
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    
    /// Register a concrete instance for a type
    func register<T>(_ type: T.Type, instance: T)
}

protocol DependenciesResolverProtocol {
    /// Resolve a service for a certain type
    func resolve<T>(_ type: T.Type) -> T
    
    /// Resolve a service for a certain type with arguments
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T
}

typealias DependencyInjectionProtocol = DependenciesRegisterProtocol & DependenciesResolverProtocol

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
    
    /// Register a factory closure for a type that requires an argument
    func register<T, Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) {
        let key = String(describing: type)
        dependencies[key] = factory
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
    
    /// Resolve a service for a certain type with arguments
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        let key = String(describing: type)
        
        /// Check for a factory closure that takes an argument
        if let factory = dependencies[key] as? (Arg) -> T {
            return factory(argument)
        }
        
        fatalError("Could not resolve dependency with argument.")
    }
    
}
