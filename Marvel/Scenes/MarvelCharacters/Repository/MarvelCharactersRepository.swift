//
//  MarvelCharactersRepository.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

class MarvelCharactersRepository: BaseRepository {
    
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
    
    func getCharactersFromCache() -> [MarvelCharacter]? {
        if let results = realmManager.getAll(MarvelCharacter.self), results.count > 0 {
            return results
        }
        return nil
    }
    
    func saveCharactersInCache(characters: [MarvelCharacter]) {
        realmManager.save(objects: characters)
    }
    
    func deleteCharactersFromCache() {
        realmManager.deleteAll()
    }
}
