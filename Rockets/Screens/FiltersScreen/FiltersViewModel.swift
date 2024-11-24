//
//  FiltersViewModel.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

protocol FiltersViewModelProtocol: ObservableObject {
    func didTapApplyFilters(with filters: Filters)
}

final class FiltersViewModel: FiltersViewModelProtocol {
    
    private let launches: [Launch]
    private let filters: Filters
    
    private let coordinator: FiltersCoordinatorProtocol
    private let filterLaunchesUseCase: FilterLaunchesUseCaseProtocol
    private weak var filtersDelegate: FiltersDelegate?
    
    init(coordinator: FiltersCoordinatorProtocol,
         filters: Filters = Filters(),
         filterLaunchesUseCase: FilterLaunchesUseCaseProtocol,
         filtersDelegate: FiltersDelegate,
         launches: [Launch]) {
        self.coordinator = coordinator
        self.filterLaunchesUseCase = filterLaunchesUseCase
        self.filtersDelegate = filtersDelegate
        self.launches = launches
        self.filters = filters
    }
    
    func didTapApplyFilters(with filters: Filters) {
        let filteredLaunches = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        filtersDelegate?.didFilter(filteredLaunches: filteredLaunches)
        coordinator.dismissFilters()
    }
    
}

