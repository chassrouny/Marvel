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

extension MarvelCharacterDTO {
    func toDomain() -> MarvelCharacter {
        let marvelCharacter = MarvelCharacter()
        marvelCharacter.id = id
        marvelCharacter.name = name
        let thumb = Thumbnail()
        thumb.path = thumbnail?.path
        thumb.extension = thumbnail?.extension
        marvelCharacter.thumbnail = thumb
        return marvelCharacter
    }
}
