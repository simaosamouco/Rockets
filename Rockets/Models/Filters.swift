//
//  Filters.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

struct Filters {
    
    var showOnlySuccessful: Bool = true
    var sortType: SortType = .ascending
    var years: [Date]?
    
}

enum SortType {
    case ascending
    case descending
}
