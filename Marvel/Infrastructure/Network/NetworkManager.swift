//
//  NetworkManager.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    
    
    static let shared = NetworkManager()
    
    private init() {}
    
    /*
     This function prepares the API request and execute it.
     Currently all the APIs have "GET" as HTTP Method, so I assumemd the encoding of the parameters is always URLEncoding.default
     */
    func execute<T: Decodable>(endpoint: EndpointProtocol, parameters: [String: Any]? = nil, responseDecodable: T.Type) async throws -> MarvelResponse<T> {
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(endpoint.baseUrl + endpoint.api, method: endpoint.httpMethod, parameters: generateParameters(parameters: parameters), encoding: URLEncoding.default).responseDecodable(of: MarvelResponse<T>.self) { response in
                switch response.result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    /*
     Based on https://developer.marvel.com/documentation/authorization:
     - the ts should be a timestamp
     - the hash is and MD5 string generated from the concatenation of ts + privatekey + publickey
     - the apikey is the public key
     We should send these parameters in every api call.
     */
    private func generateParameters(parameters: [String: Any]?) -> [String: Any] {
        var params = [String: Any]()
        let ts = Date().currentTimeMillis()
        let apiKeys = APIKeys()
        params["ts"] = ts
        params["hash"] = (String(ts) + apiKeys.privateKey + apiKeys.publicKey).MD5()
        params["apikey"] = apiKeys.publicKey
        
        //Merge additional params if available
        if let parameters {
            params.merge(parameters) { _, newValue in
                newValue
            }
        }
        return params
    }
}
