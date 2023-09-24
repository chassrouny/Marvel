//
//  MarvelCharacter.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import RealmSwift


class MarvelCharacter: Object {
    @Persisted var id: Int
    @Persisted var name: String?
    @Persisted var thumbnail: Thumbnail?
}
