//
//  CompanyInfo.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

struct CompanyInfo: Decodable {
    
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launchSites: Int
    let valuation: Int

    enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case launchSites = "launch_sites"
        case valuation
    }
    
}

