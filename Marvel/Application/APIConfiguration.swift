//
//  APIKeys.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

final class APIConfiguration {
    lazy var publicKey: String = {
        return "e41d52d70a91da66e92983710e0bfed9"
    }()
    
    lazy var privateKey: String = {
        return "acdd596d213462f6f20a3e19ab707d5537b29298"
    }()
    
    lazy var baseUrl: String = {
        return "https://gateway.marvel.com/v1/public"
    }()
}
