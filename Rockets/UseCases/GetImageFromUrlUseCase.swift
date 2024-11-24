//
//  GetImageFromUrlUseCase.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 13/10/2024.
//

import UIKit

protocol GetImageFromUrlUseCaseProtocol {
    func get(from imageURL: String) async -> UIImage
}

final class GetImageFromUrlUseCase: GetImageFromUrlUseCaseProtocol {
    
    private let imageCache: NSCache<NSString, UIImage>
    private let networkService: NetworkServiceProtocol
    private let fallbackImage: UIImage 
    
    init(networkService: NetworkServiceProtocol,
         imageCache: NSCache<NSString, UIImage> = NSCache(),
         fallbackImage: UIImage = UIImage.defaultErrorImage) {
        self.networkService = networkService
        self.imageCache = imageCache
        self.fallbackImage = fallbackImage
    }
    
    func get(from imageURL: String) async -> UIImage {
        guard let url = URL(string: imageURL) else {
            return fallbackImage
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            return cachedImage
        }
        
        do {
            let imageData = try await networkService.fetchData(from: url)
            if let image = UIImage(data: imageData) {
                imageCache.setObject(image, forKey: NSString(string: imageURL))
                return image
            }
        } catch {
            return fallbackImage
        }
        
        return fallbackImage
    }

}
