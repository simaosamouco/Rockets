//
//  XCTestCase.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import XCTest

extension XCTestCase {
    
    func loadJSONData(filename: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: filename, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
}
