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
        return "https://gateway.marvel.com/v1/public"
    }
    
    var api: String {
        return "/characters"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
}
