//
//  MarvelResponse.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: ResponseData<T>
}
