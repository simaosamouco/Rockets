//
//  LaunchCellViewModel.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 27/11/2024.
//

import UIKit

protocol LaunchCellViewModelProtocol {
    var missionName: String { get }
    var launchDate: String { get }
    var rocketName: String { get }
    var daysAgo: String { get }
    var successImage: UIImage { get }
    var successImageTintColor: UIColor { get }
    func getImage() async -> UIImage
    func cancelImageTask()
}

final class LaunchCellViewModel: LaunchCellViewModelProtocol {
    
    var missionName: String
    var launchDate: String
    var rocketName: String
    var daysAgo: String
    var successImage: UIImage
    var successImageTintColor: UIColor
    
    private let launch: Launch
    private var imageTask: Task<UIImage, Never>?
    private let getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol
    private let formatter = DateFormatter()
    
    init(launch: Launch, getImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol) {
        self.launch = launch
        self.missionName = launch.name
        self.rocketName = launch.rocket
        formatter.dateFormat = "dd-MM-yyyy"
        self.launchDate = formatter.string(from: launch.dateLocal)
        self.daysAgo = launch.dateLocal.isInTheFuture ? "-\(launch.dateLocal.daysSince)" : " +\(launch.dateLocal.daysSince)"
        
        if let success = launch.wasSuccessful {
            successImage = success ? UIImage(systemName: "checkmark")! : UIImage(systemName: "xmark")!
            successImageTintColor = success ? .green : .red
        } else {
            successImage = UIImage(systemName: "questionmark")!
            successImageTintColor = .black
        }
        
        self.getImageFromUrlUseCase = getImageFromUrlUseCase
    }

    func getImage() async -> UIImage {
        imageTask?.cancel()
        
        imageTask = Task {
            if Task.isCancelled { return UIImage() }
            return await getImageFromUrlUseCase.get(from: launch.icon ?? "")
        }
        
        return await imageTask?.value ?? UIImage() 
    }
    
    func cancelImageTask() {
        imageTask?.cancel()
        imageTask = nil
    }
    
}
