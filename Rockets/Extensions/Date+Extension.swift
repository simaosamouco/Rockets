//
//  Date+Extension.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 14/10/2024.
//

import Foundation

extension Date {
    
    public var isInTheFuture: Bool {
        return self > Date()
    }
    
    public var daysSince: Int {
        let calendar = Calendar.current
        let startOfCurrentDay = calendar.startOfDay(for: Date())
        let startOfGivenDay = calendar.startOfDay(for: self)
        return calendar.dateComponents([.day], from: startOfGivenDay, to: startOfCurrentDay).day ?? 0
    }
     
}
