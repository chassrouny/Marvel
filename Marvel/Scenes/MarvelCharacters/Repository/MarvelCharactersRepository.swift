//
//  MarvelCharactersRepository.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

class MarvelCharactersRepository {
    private let networkManager = NetworkManager.shared
    
    func getCharacters(offset: Int, limit: Int = 20) async -> MarvelResponse<MarvelCharacterDTO>? {
        do {
            let endpoint = MarvelCharactersEndpoint()
            let additionalParameters = ["offset": offset, "limit": limit]
            let result = try await networkManager.execute(endpoint: endpoint, parameters: additionalParameters, responseDecodable: MarvelCharacterDTO.self)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
