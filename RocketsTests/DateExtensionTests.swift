//
//  DateExtensionTests.swift
//  RocketsTests
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import XCTest

final class DateExtensionTests: XCTestCase {

    func testIsInTheFuture_WhenDateIsInTheFuture() {
        let futureDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
        
        let result = futureDate.isInTheFuture
        
        XCTAssertTrue(result)
    }
    
    func testIsInTheFuture_WhenDateIsInThePast() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        
        let result = pastDate.isInTheFuture
        
        XCTAssertFalse(result)
    }
    
    func testIsInTheFuture_WhenDateIsNow() {
        let nowDate = Date()
        
        let result = nowDate.isInTheFuture
        
        XCTAssertFalse(result)
    }
    
    func testDaysSince_WhenDateIsInThePast() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        
        let result = pastDate.daysSince
        
        XCTAssertEqual(result, 5)
    }
    
    func testDaysSince_WhenDateIsInTheFuture() {
        let futureDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!
        
        let result = futureDate.daysSince
        
        XCTAssertEqual(result, -5)
    }
    
    func testDaysSince_WhenDateIsToday() {
        let todayDate = Date()
        
        let result = todayDate.daysSince
        
        XCTAssertEqual(result, 0)
    }
    
}

