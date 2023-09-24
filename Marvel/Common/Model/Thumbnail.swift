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
}
