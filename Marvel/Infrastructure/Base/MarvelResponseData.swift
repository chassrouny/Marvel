//
//  MarvelResponseData.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct ResponseData<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]?
}
