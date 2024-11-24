//
//  Launch.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

struct Launch: Decodable {
    
    let wasSuccessful: Bool?
    let name: String
    let dateLocal: Date
    let rocket: String
    let icon: String?
    let article: String
     
}

/// Moving the `init(from decoder: Decoder)` into an extension to preserve the memberwise initializer for`Launch`
extension Launch {
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case name
        case dateLocal = "date_local"
        case rocket
        case links
    }
    
    enum LinksCodingKeys: String, CodingKey {
        case patch
        case article
    }
    
    enum PatchCodingKeys: String, CodingKey {
        case small
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /// Basic properties
        wasSuccessful = try container.decodeIfPresent(Bool.self, forKey: .success)
        name = try container.decode(String.self, forKey: .name)
        rocket = try container.decode(String.self, forKey: .rocket)
        
        /// Decoding `dateLocal` into a Date object
        let dateString = try container.decode(String.self, forKey: .dateLocal)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        guard let parsedDate = formatter.date(from: dateString) else {
            throw RocketsErros.decodingFailed
        }
        
        dateLocal = parsedDate
        
        /// Decode nested data
        let linksContainer = try? container.nestedContainer(keyedBy: LinksCodingKeys.self, forKey: .links)
        let patchContainer = try? linksContainer?.nestedContainer(keyedBy: PatchCodingKeys.self, forKey: .patch)
        icon = try patchContainer?.decodeIfPresent(String.self, forKey: .small)
        article = try linksContainer?.decodeIfPresent(String.self, forKey: .article) ?? ""
    }
    
}
