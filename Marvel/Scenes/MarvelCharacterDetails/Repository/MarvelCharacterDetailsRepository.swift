//
//  MarvelCharacterDetailsRepository.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

class MarvelCharacterDetailsRepository: BaseRepository {
    
    func getComics(characterId: Int, limit: Int = 3) async -> MarvelResponse<ComicDTO>? {
        do {
            let endpoint = MarvelCharacterDetailsEndpoint.comics(characterId: characterId)
            let additionalParameters = ["limit": limit]
            let result = try await networkManager.execute(endpoint: endpoint, parameters: additionalParameters, responseDecodable: ComicDTO.self)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getEvents(characterId: Int, limit: Int = 3) async -> MarvelResponse<EventDTO>? {
        do {
            let endpoint = MarvelCharacterDetailsEndpoint.events(characterId: characterId)
            let additionalParameters = ["limit": limit]
            let result = try await networkManager.execute(endpoint: endpoint, parameters: additionalParameters, responseDecodable: EventDTO.self)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getSeries(characterId: Int, limit: Int = 3) async -> MarvelResponse<SeriesDTO>? {
        do {
            let endpoint = MarvelCharacterDetailsEndpoint.series(characterId: characterId)
            let additionalParameters = ["limit": limit]
            let result = try await networkManager.execute(endpoint: endpoint, parameters: additionalParameters, responseDecodable: SeriesDTO.self)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getStories(characterId: Int, limit: Int = 3) async -> MarvelResponse<StoryDTO>? {
        do {
            let endpoint = MarvelCharacterDetailsEndpoint.stories(characterId: characterId)
            let additionalParameters = ["limit": limit]
            let result = try await networkManager.execute(endpoint: endpoint, parameters: additionalParameters, responseDecodable: StoryDTO.self)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
