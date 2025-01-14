//
//  RocketsViewModel.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

import UIKit

protocol RocketsViewModelProtocol: ObservableObject {
    var textPublisher: Published<String>.Publisher { get }
    var launchesViewModelsPublisher: Published<[LaunchCellViewModel]>.Publisher { get }
    var launchesCount: Int { get }
    func didLoad()
    func onTapFilters()
    func onSelectLaunch(_ launch: LaunchCellViewModel)
    func getLaunchCell(for: UITableView, at: IndexPath) -> UITableViewCell
    func launchViewModel(at index: Int) -> LaunchCellViewModel?
}

protocol FiltersDelegate: AnyObject {
    func didFilter(filteredLaunches: [Launch])
}

final class RocketsViewModel: RocketsViewModelProtocol, FiltersDelegate {
    
    @Published var text: String = ""
    var textPublisher: Published<String>.Publisher { $text }
    
    @Published var launchesViewModels: [LaunchCellViewModel] = []
    var launchesViewModelsPublisher: Published<[LaunchCellViewModel]>.Publisher { $launchesViewModels }
    var launchesCount: Int { launchesViewModels.count }
    
    private var launches: [Launch] = []
    private let launchViewModelFactoryUseCase: LaunchViewModelFactoryUseCaseProtocol
    private let getRocketsDataUseCase: GetRocketsDataUseCaseProtocol
    private let cellFactory: FactoryTableViewCell
    private let coordinator: RocketsCoordinatorProtocol
    
    init(coordinator: RocketsCoordinatorProtocol,
         getRocketsDataUseCase: GetRocketsDataUseCaseProtocol,
         launchViewModelFactoryUseCase: LaunchViewModelFactoryUseCaseProtocol,
         cellFactory: FactoryTableViewCell) {
        self.coordinator = coordinator
        self.getRocketsDataUseCase = getRocketsDataUseCase
        self.launchViewModelFactoryUseCase = launchViewModelFactoryUseCase
        self.cellFactory = cellFactory
    }
    
    func didLoad() {
        Task {
            do {
                let (launches, companyInfo) = try await getRocketsDataUseCase.get()
                updateUI(launches: launches, companyInfo: companyInfo)
            } catch {
                coordinator.showError(error)
            }
        }
    }
    
    private func updateUI(launches: [Launch], companyInfo: CompanyInfo) {
        self.launches = launches
        self.launchesViewModels = launchViewModelFactoryUseCase.execute(with: launches)
        self.text = composeCompanyInfoText(for: companyInfo)
    }
    
    func onTapFilters() {
        coordinator.presentFilters(launches: launches, delegate: self)
    }
    
    func onSelectLaunch(_ launch: LaunchCellViewModel) {
        if let articleUrl: URL = URL(string: launch.article) {
            coordinator.openWebview(articleUrl)
        } else {
            coordinator.showError(RocketsErros.invalidArticleURL)
        }
    }
    
    func getLaunchCell(for tableView: UITableView, at index: IndexPath) -> UITableViewCell {
        return cellFactory.createLaunchCell(for: tableView, at: index)
    }
    
    func launchViewModel(at index: Int) -> LaunchCellViewModel? {
        guard index >= 0 && index < launchesViewModels.count else {
            return nil
        }
        return launchesViewModels[index]
    }
    
    /// FiltersDelegate
    func didFilter(filteredLaunches: [Launch]) {
        self.launchesViewModels = launchViewModelFactoryUseCase.execute(with: filteredLaunches)
    }
    
    func composeCompanyInfoText(for companyInfo: CompanyInfo) -> String {
        return """
        \(companyInfo.name) was founded by \(companyInfo.founder) in \(companyInfo.founded).
        It has \(companyInfo.employees) employees, \(companyInfo.launchSites) launch sites,
        and is valued at USD \(companyInfo.valuation).
        """
    }
    
}
