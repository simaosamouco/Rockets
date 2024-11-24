//
//  FilterLaunchesUseCaseTests.swift
//  RocketsTests
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import XCTest
@testable import Rockets

final class FilterLaunchesUseCaseTests: XCTestCase {

    var filterLaunchesUseCase: FilterLaunchesUseCase!

    override func setUp() {
        super.setUp()
        filterLaunchesUseCase = FilterLaunchesUseCase()
    }

    override func tearDown() {
        filterLaunchesUseCase = nil
        super.tearDown()
    }

    func testSortByType_Ascending() {
        let launch1 = Launch(wasSuccessful: true,
                             name: "Launch1",
                             dateLocal: Date(timeIntervalSince1970: 1000),
                             rocket: "Falcon 1",
                             icon: nil,
                             article: "Article 1")
        let launch2 = Launch(wasSuccessful: false,
                             name: "Launch2",
                             dateLocal: Date(timeIntervalSince1970: 2000),
                             rocket: "Falcon 9",
                             icon: nil,
                             article: "Article 2")
        let launch3 = Launch(wasSuccessful: true,
                             name: "Launch3",
                             dateLocal: Date(timeIntervalSince1970: 3000),
                             rocket: "Falcon Heavy",
                             icon: nil,
                             article: "Article 3")
        
        let launches = [launch3, launch1, launch2]
        let filters = Filters(showOnlySuccessful: false, sortType: .ascending, years: [])
        
        let result = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        
        XCTAssertEqual(result[0].dateLocal, launch1.dateLocal)
        XCTAssertEqual(result[1].dateLocal, launch2.dateLocal)
        XCTAssertEqual(result[2].dateLocal, launch3.dateLocal)
    }

    func testSortByType_Descending() {
        let launch1 = Launch(wasSuccessful: true,
                             name: "Launch1",
                             dateLocal: Date(timeIntervalSince1970: 1000),
                             rocket: "Falcon 1",
                             icon: nil,
                             article: "Article 1")
        let launch2 = Launch(wasSuccessful: false,
                             name: "Launch2",
                             dateLocal: Date(timeIntervalSince1970: 2000),
                             rocket: "Falcon 9",
                             icon: nil,
                             article: "Article 2")
        let launch3 = Launch(wasSuccessful: true,
                             name: "Launch3",
                             dateLocal: Date(timeIntervalSince1970: 3000),
                             rocket: "Falcon Heavy",
                             icon: nil,
                             article: "Article 3")
        
        let launches = [launch1, launch2, launch3]
        let filters = Filters(showOnlySuccessful: false, sortType: .descending, years: [])
        
        let result = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        
        XCTAssertEqual(result[0].dateLocal, launch3.dateLocal)
        XCTAssertEqual(result[1].dateLocal, launch2.dateLocal)
        XCTAssertEqual(result[2].dateLocal, launch1.dateLocal)
    }
    
    func testFilterLaunches_Successful() {
        
        let launch1 = Launch(wasSuccessful: true,
                             name: "Launch1",
                             dateLocal: Date(),
                             rocket: "Falcon 1",
                             icon: nil,
                             article: "Article 1")
        let launch2 = Launch(wasSuccessful: false,
                             name: "Launch2",
                             dateLocal: Date(),
                             rocket: "Falcon 9",
                             icon: nil,
                             article: "Article 2")
        
        let launches = [launch1, launch2]
        
        let filters = Filters(showOnlySuccessful: true, sortType: .ascending, years: [])
        
        let result = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result[0].wasSuccessful ?? false)
    }
    
    func testFilter_ByYears() {
        let year2020 = Calendar.current.date(from: DateComponents(year: 2020))!
        let year2021 = Calendar.current.date(from: DateComponents(year: 2021))!
        let year2022 = Calendar.current.date(from: DateComponents(year: 2022))!
        
        let launch1 = Launch(wasSuccessful: true,
                             name: "Launch1",
                             dateLocal: year2020,
                             rocket: "Falcon 1",
                             icon: nil,
                             article: "Article 1")
        let launch2 = Launch(wasSuccessful: false,
                             name: "Launch2",
                             dateLocal: year2021,
                             rocket: "Falcon 9",
                             icon: nil,
                             article: "Article 2")
        let launch3 = Launch(wasSuccessful: true,
                             name: "Launch3",
                             dateLocal: year2022,
                             rocket: "Falcon Heavy",
                             icon: nil,
                             article: "Article 3")
        
        let launches = [launch1, launch2, launch3]
        let filters = Filters(showOnlySuccessful: false,
                              sortType: .ascending,
                              years: [year2020, year2021])
        
        let result = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.dateLocal == year2020 })
        XCTAssertTrue(result.contains { $0.dateLocal == year2021 })
        XCTAssertFalse(result.contains { $0.dateLocal == year2022 })
    }

    func testSortAndFilter_BySuccessAndYears() {
        let year2020 = Calendar.current.date(from: DateComponents(year: 2020))!
        let year2021 = Calendar.current.date(from: DateComponents(year: 2021))!
        let year2022 = Calendar.current.date(from: DateComponents(year: 2022))!
        
        let launch1 = Launch(wasSuccessful: true,
                             name: "Launch1",
                             dateLocal: year2020,
                             rocket: "Falcon 1",
                             icon: nil,
                             article: "Article 1")
        let launch2 = Launch(wasSuccessful: false,
                             name: "Launch2",
                             dateLocal: year2021,
                             rocket: "Falcon 9",
                             icon: nil,
                             article: "Article 2")
        let launch3 = Launch(wasSuccessful: true,
                             name: "Launch3",
                             dateLocal: year2022,
                             rocket: "Falcon Heavy",
                             icon: nil,
                             article: "Article 3")
        
        let launches = [launch3, launch2, launch1]
        
        let filters = Filters(showOnlySuccessful: true,
                              sortType: .ascending,
                              years: [year2020, year2022])
        
        let result = filterLaunchesUseCase.filterLaunches(launches: launches, filters: filters)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result[0].dateLocal == year2020)
        XCTAssertTrue(result[1].dateLocal == year2022)
    }
    
}

