//
//  ViewCode.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

/// Created to help organize the View Controllers view code.
protocol ViewCode {
    func addViews()
    func addConstraints()
    func addStyling()
    func addBindings()
}

extension ViewCode {
    
    /// Default method to set up the views by calling the required methods in a sequence.
    func setUpViews() {
        addViews()
        addConstraints()
        addStyling()
        addBindings()
    }
    
    /// Empty default implementaion to avoid having empty methods in a view controller that doesn't require bindings.
    func addBindings() { }
    
}
