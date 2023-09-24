//
//  EventDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct EventDTO: Decodable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: ThumbnailDTO?
}

extension EventDTO {
    func toDomain() -> MarvelEvent {
        var event = MarvelEvent()
        event.title = title
        
        let thumb = Thumbnail()
        thumb.path = thumbnail?.path
        thumb.extension = thumbnail?.extension
        
        event.thumbnail = thumb
        return event
    }
}
