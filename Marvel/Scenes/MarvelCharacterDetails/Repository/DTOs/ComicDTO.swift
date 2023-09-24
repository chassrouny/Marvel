//
//  ComicDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct ComicDTO: Decodable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: ThumbnailDTO?
}

extension ComicDTO {
    func toDomain() -> MarvelComic {
        var comic = MarvelComic()
        comic.title = title
        
        let thumb = Thumbnail()
        thumb.path = thumbnail?.path
        thumb.extension = thumbnail?.extension
        
        comic.thumbnail = thumb
        return comic
    }
}
