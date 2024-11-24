//
//  GetImageFromUrlUseCaseTests.swift
//  RocketsTests
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import XCTest
@testable import Rockets

final class GetImageFromUrlUseCaseTests: XCTestCase {
    
    var networkServiceMock: NetworkServiceMock!
    var imageCache: NSCache<NSString, UIImage>!
    var useCase: GetImageFromUrlUseCase!
    var fallbackImage: UIImage!
    
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        imageCache = NSCache<NSString, UIImage>()
        fallbackImage = UIImage.defaultErrorImage
        useCase = GetImageFromUrlUseCase(networkService: networkServiceMock,
                                         imageCache: imageCache,
                                         fallbackImage: fallbackImage)
    }
    
    override func tearDown() {
        useCase = nil
        networkServiceMock = nil
        imageCache = nil
        fallbackImage = nil
        super.tearDown()
    }
    
    func testGetImage_WhenUrlIsInvalid() async {
        let invalidURL = "invalid url"
        
        let result = await useCase.get(from: invalidURL)
        
        XCTAssertEqual(result, fallbackImage)
    }
    
    func testGetImage_WhenImageIsCached() async {
        let validURL = "http://example.com/image"
        let cachedImage = UIImage(systemName: "star")!
        imageCache.setObject(cachedImage, forKey: NSString(string: validURL))
        
        let result = await useCase.get(from: validURL)
        
        XCTAssertEqual(result, cachedImage)
    }
    
    func testGetImage_WhenImageIsNotCached() async {
        let validURL = "http://example.com/image"
        let fetchedImage = UIImage(systemName: "moon")!
        networkServiceMock.mockData = fetchedImage.pngData()  // Setting the mock network response as PNG data
        
        let result = await useCase.get(from: validURL)
        
        let resultData = result.pngData()
        let expectedData = fetchedImage.pngData()
        
        XCTAssertEqual(resultData?.hashValue, expectedData?.hashValue)
    }

}
