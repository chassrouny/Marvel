//
//  ThumbnailDTO.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

import Foundation

struct ThumbnailDTO: Decodable {
    let path: String?
    let `extension`: String?
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case `extension` = "extension"
    }
}

