//
//  RocketsViewModel.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

import UIKit

protocol RocketsViewModelProtocol: ObservableObject {
    var textPublisher: Published<String>.Publisher { get }
    var launchesViewModelsPublisher: Published<[LaunchCellViewModelProtocol]>.Publisher { get }
    func didLoad() async
    func onTapFilters()
    func onSelectLaunch(_ launch: LaunchCellViewModelProtocol)
    func getImage(_ imageURL: String) async -> UIImage
}

protocol FiltersDelegate: AnyObject {
    func didFilter(filteredLaunches: [Launch])
}

final class RocketsViewModel: RocketsViewModelProtocol, FiltersDelegate {
    
    @Published var text: String = ""
    var textPublisher: Published<String>.Publisher { $text }
    
    @Published var launchesViewModels: [LaunchCellViewModelProtocol] = []
    var launchesViewModelsPublisher: Published<[LaunchCellViewModelProtocol]>.Publisher { $launchesViewModels }
    
    private var launches: [Launch] = []
    
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    private let getRocketsDataUseCase: GetRocketsDataUseCaseProtocol
    private let coordinator: RocketsCoordinatorProtocol
    
    init(coordinator: RocketsCoordinatorProtocol,
         getRocketsDataUseCase: GetRocketsDataUseCaseProtocol,
         getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.coordinator = coordinator
        self.getRocketsDataUseCase = getRocketsDataUseCase
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }
    
    func didLoad() async {
        do {
            let (launches, companyInfo) = try await getRocketsDataUseCase.get()
            updateUI(launches: launches, companyInfo: companyInfo)
        } catch {
            coordinator.showError(error)
        }
    }
    
    private func updateUI(launches: [Launch], companyInfo: CompanyInfo) {
        self.launches = launches
        self.launchesViewModels = launches.compactMap({ LaunchCellViewModel(launch: $0,
                                                                      getImageFromUrlUseCase: getImageFromUrlUseCase) })
        self.text = composeCompanyInfoText(for: companyInfo)
    }
    
    func getImage(_ imageURL: String) async -> UIImage {
        return await getImageFromUrlUseCase.get(from: imageURL)
    }
    
    func onTapFilters() {
        coordinator.presentFilters(launches: launches, delegate: self)
    }
    
    func onSelectLaunch(_ launch: LaunchCellViewModelProtocol) {
        if let articleUrl: URL = URL(string: launch.article) {
            coordinator.openWebview(articleUrl)
        } else {
            coordinator.showError(RocketsErros.invalidArticleURL)
        }
    }
    
    /// FiltersDelegate
    func didFilter(filteredLaunches: [Launch]) {
        launchesViewModels = filteredLaunches.map( { LaunchCellViewModel(launch: $0,
                                                                         getImageFromUrlUseCase: getImageFromUrlUseCase)} )
    }
    
    func composeCompanyInfoText(for companyInfo: CompanyInfo) -> String {
        return """
        \(companyInfo.name) was founded by \(companyInfo.founder) in \(companyInfo.founded).
        It has \(companyInfo.employees) employees, \(companyInfo.launchSites) launch sites,
        and is valued at USD \(companyInfo.valuation).
        """
    }
    
}
