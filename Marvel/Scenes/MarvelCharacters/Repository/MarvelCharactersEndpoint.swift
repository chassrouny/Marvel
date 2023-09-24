//
//  MarvelCharacterEndpoint.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import Alamofire

struct MarvelCharactersEndpoint: EndpointProtocol {
    var baseUrl: String {
        return APIConfiguration().baseUrl
    }
    
    var api: String {
        return "/characters"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
}
