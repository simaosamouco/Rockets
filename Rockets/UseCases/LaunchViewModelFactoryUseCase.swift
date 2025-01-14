//
//  LaunchViewModelFactoryUseCase.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 04/01/2025.
//

import Foundation

protocol LaunchViewModelFactoryUseCaseProtocol {
    func execute(with launches: [Launch]) -> [LaunchCellViewModel]
}

struct LaunchViewModelFactoryUseCase: LaunchViewModelFactoryUseCaseProtocol {
    
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    
    init(getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }
    
    func execute(with launches: [Launch]) -> [LaunchCellViewModel] {
        launches.map( { LaunchCellViewModel(launch: $0,
                                            getImageFromUrlUseCase: getImageFromUrlUseCase) }  )
    }
    
}
