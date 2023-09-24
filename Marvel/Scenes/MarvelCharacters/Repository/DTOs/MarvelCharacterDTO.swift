//
//  MarvelCharacterDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct MarvelCharacterDTO: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: ThumbnailDTO?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
    }
}
