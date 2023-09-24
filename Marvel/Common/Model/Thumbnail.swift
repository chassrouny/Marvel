//
//  Thumbnail.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import RealmSwift

class Thumbnail: Object {
    @Persisted var path: String?
    @Persisted var `extension`: String?
    
    func getUrl(size: ThumbnailImageSize? = nil) -> String? {
        guard let path, let `extension` else { return nil }
        if let size {
            return "\(path)/\(size.rawValue).\(`extension`)"
        }
        return "\(path).\(`extension`)"
    }
}

//Based on https://developer.marvel.com/documentation/images
enum ThumbnailImageSize: String {
    case portrait_small = "portrait_small"
    case portrait_medium = "portrait_medium"
    case portrait_xlarge = "portrait_xlarge"
    case portrait_fantastic = "portrait_fantastic"
    case portrait_uncanny = "portrait_uncanny"
    case portrait_incredible = "portrait_incredible"

    
    case standard_small = "standard_small"
    case standard_medium = "standard_medium"
    case standard_large = "standard_large"
    case standard_xlarge = "standard_xlarge"
    case standard_fantastic = "standard_fantastic"
    case standard_amazing = "standard_amazing"

    case landscape_small = "landscape_small"
    case landscape_medium = "landscape_medium"
    case landscape_large = "landscape_large"
    case landscape_xlarge = "landscape_xlarge"
    case landscape_amazing = "landscape_amazing"
    case landscape_incredible = "landscape_incredible"

}
