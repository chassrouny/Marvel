//
//  SeriesDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct SeriesDTO: Decodable {
    var id: Int
    var title: String?
    var description: String?
    var thumbnail: ThumbnailDTO?
}

extension SeriesDTO {
    func toDomain() -> MarvelSeries {
        var series = MarvelSeries()
        series.title = title
        
        let thumb = Thumbnail()
        thumb.path = thumbnail?.path
        thumb.extension = thumbnail?.extension
        
        series.thumbnail = thumb
        return series
    }
}
