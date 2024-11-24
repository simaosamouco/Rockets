//
//  RocketsErros.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

enum RocketsErros: Error {
    
    case invalidURL
    case decodingFailed
    case fecthingDataFailed
    case invalidArticleURL
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .decodingFailed:
            return "Decoding failed."
        case .fecthingDataFailed:
            return "Fetching data failed."
        case .invalidArticleURL:
            return "Could not open the article."
        }
    }
    
}
