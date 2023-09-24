//
//  StoryDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct StoryDTO: Decodable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: ThumbnailDTO?
}


extension StoryDTO {
    func toDomain() -> MarvelStory {
        var story = MarvelStory()
        story.title = title
        return story
    }
}
