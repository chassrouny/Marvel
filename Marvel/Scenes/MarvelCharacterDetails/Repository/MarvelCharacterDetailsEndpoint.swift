//
//  MarvelCharacterDetailsEndpoint.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import Alamofire

enum MarvelCharacterDetailsEndpoint: EndpointProtocol {
    case comics(characterId: Int)
    case events(characterId: Int)
    case series(characterId: Int)
    case stories(characterId: Int)
    
    
    var baseUrl: String {
        return "https://gateway.marvel.com/v1/public"
    }
    
    var api: String {
        switch self {
        case .comics(let characterId):
            return "/characters/" + String(characterId) + "/comics"
        case .events(let characterId):
            return "/characters/" + String(characterId) + "/events"
        case .series(let characterId):
            return "/characters/" + String(characterId) + "/series"
        case .stories(let characterId):
            return "/characters/" + String(characterId) + "/stories"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
