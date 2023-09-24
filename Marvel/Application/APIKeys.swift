//
//  APIKeys.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

final class APIKeys {
    lazy var publicKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "PublicApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var privateKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "PrivateApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
}
