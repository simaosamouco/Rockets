//
//  RocketsServicesTests.swift
//  RocketsTests
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import XCTest
@testable import Rockets

final class RocketsServicesTests: XCTestCase {
    
    var networkServiceMock: NetworkServiceMock!
    var rocketsServices: RocketsServices!
    
    override func setUp() {
        super.setUp()
        networkServiceMock = NetworkServiceMock()
        rocketsServices = RocketsServices(networkService: networkServiceMock)
    }
    
    override func tearDown() {
        networkServiceMock = nil
        rocketsServices = nil
        super.tearDown()
    }
    
    func testGetRocketLaunches_Success() async throws {
        let mockLaunchesData = loadJSONData(filename: "RocketsLaunchesJSON")
        networkServiceMock.mockData = mockLaunchesData
        
        let launches = try await rocketsServices.getRocketLaunches()
        
        XCTAssertEqual(launches.count, 2) // Number os launches in the JSON file
        XCTAssertEqual(launches.first?.name, "FalconSat")
    }
    
    func testGetCompanyInfo_Success() async throws {
        let mockCompanyInfoData = loadJSONData(filename: "CompanyInfoJSON")
        networkServiceMock.mockData = mockCompanyInfoData
        
        let companyInfo = try await rocketsServices.getCompanyInfo()
        
        XCTAssertEqual(companyInfo.name, "SpaceX")
        XCTAssertEqual(companyInfo.founder, "Elon Musk")
    }
    
}
