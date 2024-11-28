//
//  LabelFactoryUseCase.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 28/11/2024.
//

import UIKit

protocol LabelFactoryUseCaseProtocol {
    func makeLabel(text: String) -> UILabel
    func makeLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) -> UILabel
    func makeLabel() -> UILabel
    func makeLabel(numberOfLines: Int) -> UILabel
    func makeLabel(textColor: UIColor) -> UILabel
    func makeTitleLabel(text: String) -> UILabel
}

/// Returns a `UILabel` based on selected attributes
/// TODO: Needs improvement to cover more scenarios
final class LabelFactoryUseCase: LabelFactoryUseCaseProtocol {
    func makeTitleLabel(text: String) -> UILabel {
        let lb = UILabel()
        lb.text = text
        lb.backgroundColor = .black
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }
    
    func makeLabel(numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeLabel(textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    func makeLabel(text: String) -> UILabel {
        return makeLabel(text: text, fontSize: 14, weight: .medium, textColor: .black)
    }
    
    func makeLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}


