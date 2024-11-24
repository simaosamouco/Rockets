//
//  Endpoints.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

enum Endpoints {
    
    case getLaunches
    case getCompanyInfo
    
    private static let baseURLString = "https://api.spacexdata.com/v4"
    
    func url() throws -> URL {
        let path: String
        
        switch self {
        case .getLaunches:
            path = "/launches"
        case .getCompanyInfo:
            path = "/company"
        }
        
        guard let url = URL(string: Endpoints.baseURLString + path) else {
            throw RocketsErros.invalidURL
        }
        
        return url
    }
    
}

