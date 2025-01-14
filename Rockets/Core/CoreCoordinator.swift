//
//  Coordinator.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

import UIKit

protocol CoreCoordinatorProtocol {
    var navigationController: UINavigationController { get }
}

public class CoreCoordinator: CoreCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

/// Extension to provide default methods for `CoreCoordinatorProtocol`
extension CoreCoordinatorProtocol {
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToScreen(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentScreen(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func popToViewController(ofType type: AnyClass, animated: Bool = true) {
        if let viewController = navigationController.viewControllers.first(where: { $0.isKind(of: type) }) {
            navigationController.popToViewController(viewController, animated: animated)
        }
    }
   
    func presentFullscreen(_ viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    func openURL(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)],
                   preferredStyle: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alertController.addAction(action)
        }

        Task { @MainActor in
            navigationController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
