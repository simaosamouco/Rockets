//
//  LaunchCellViewModel.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 27/11/2024.
//

import UIKit

protocol LaunchCellViewModelProtocol: Hashable {
    var missionName: String { get }
    var launchDate: String { get }
    var rocketName: String { get }
    var daysAgo: String { get }
    var successImage: UIImage { get }
    var successImageTintColor: UIColor { get }
    var article: String { get }
    func getImage() async -> UIImage
    func cancelImageTask()
}

final class LaunchCellViewModel: LaunchCellViewModelProtocol {
  
    // MARK: - Properties
    let missionName: String
    let launchDate: String
    let rocketName: String
    let daysAgo: String
    let successImage: UIImage
    let successImageTintColor: UIColor
    let article: String
    
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    private var imageTask: Task<UIImage, Never>?
    private let launch: Launch
    
    /// created as `static` so that its only created once and shared amongst all `LaunchCellViewModel` instances
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    // MARK: - Initialization
    init(launch: Launch, getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.launch = launch
        self.missionName = launch.name
        self.rocketName = launch.rocket
        self.article = launch.article
        self.launchDate = Self.formatDate(launch.dateLocal)
        self.daysAgo = Self.calculateDaysAgo(from: launch.dateLocal)
        (self.successImage, self.successImageTintColor) = Self.getLaunchStatusAssets(success: launch.wasSuccessful)
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }
    
    // MARK: - Methods
    func getImage() async -> UIImage {
        imageTask = Task { [weak self] in
            guard let self = self else { return UIImage() }
            if Task.isCancelled { return UIImage() }
            return await self.getImageFromUrlUseCase.get(from: launch.icon ?? "")
        }
        
        return await imageTask?.value ?? UIImage()
    }
    
    func cancelImageTask() {
        imageTask?.cancel()
        imageTask = nil
    }
    
    // MARK: - Helpers
    private static func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    private static func calculateDaysAgo(from date: Date) -> String {
        return date.isInTheFuture
            ? "-\(date.daysSince)"
            : "+\(date.daysSince)"
    }

    private static func getLaunchStatusAssets(success: Bool?) -> (UIImage, UIColor) {
        guard let success = success else {
            return (UIImage(systemName: "questionmark")!, .black)
        }
        return success
            ? (UIImage(systemName: "checkmark")!, .green)
            : (UIImage(systemName: "xmark")!, .red)
    }
    
    static func == (lhs: LaunchCellViewModel, rhs: LaunchCellViewModel) -> Bool {
        return lhs.missionName == rhs.missionName &&
        lhs.launchDate == rhs.launchDate &&
        lhs.rocketName == rhs.rocketName &&
        lhs.daysAgo == rhs.daysAgo &&
        lhs.article == rhs.article
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(missionName)
        hasher.combine(launchDate)
        hasher.combine(rocketName)
        hasher.combine(daysAgo)
        hasher.combine(article)
    }
    
}
