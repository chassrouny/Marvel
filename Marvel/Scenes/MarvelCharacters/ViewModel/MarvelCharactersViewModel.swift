//
//  MarvelCharactersViewModel.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

class MarvelCharatersViewModel {
    let repository: MarvelCharactersRepository
    weak var delegate: MarvelCharactersViewModelProtocol?
    
    private var marvelCharacters: [MarvelCharacter] = []
    
    private var offset: Int = 0
    var hasMore: Bool = false
    private var isLoading: Bool = false
    
    required init() {
        repository = MarvelCharactersRepository()
    }
    
    func reset() {
        offset = 0
        hasMore = false
        isLoading = false
    }
    
    func fetchCharacters(isSilent: Bool) {
        if offset == 0, let cachedResults = fetchCharactersFromRealm() {
            marvelCharacters.removeAll()
            marvelCharacters.append(contentsOf: cachedResults)
            self.delegate?.didFetchCharacters()
            fetchCharactersFromBackend(showLoader: false)
        } else {
            fetchCharactersFromBackend(showLoader: !isSilent)
        }
    }
    
    private func fetchCharactersFromBackend(showLoader: Bool) {
        Task {
            if isLoading == false {
                isLoading = true
                
                if showLoader == true {
                    DispatchQueue.main.async {
                        self.delegate?.showLoader()
                    }
                }
                
                if let response = await repository.getCharacters(offset: offset) {
                    if let items = response.data.results, items.count > 0 {
                        let mappedItems = mapDTOtoCharacters(array: items)
                        if offset == 0 {
                            marvelCharacters.removeAll()
                            DispatchQueue.main.async {
                                self.repository.deleteCharactersFromCache()
                                self.repository.saveCharactersInCache(characters: mappedItems)
                            }
                        }
                        marvelCharacters.append(contentsOf: mappedItems)
                    }
                    
                    if response.data.offset + response.data.count != response.data.total {
                        offset = offset + response.data.count
                        hasMore = true
                    } else {
                        hasMore = false
                    }
                    
                    DispatchQueue.main.async {
                        self.delegate?.didFetchCharacters()
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.didFailToFetchCharacters()
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.hideLoader()
                }
                isLoading = false
            }
        }
    }
    
    private func fetchCharactersFromRealm() -> [MarvelCharacter]? {
        return repository.getCharactersFromCache()
    }
    
    func charcterAt(index: Int) -> MarvelCharacter {
        return marvelCharacters[index]
    }
    
    func charactersCount() -> Int {
        return marvelCharacters.count
    }
    
    private func mapDTOtoCharacters(array: [MarvelCharacterDTO]) -> [MarvelCharacter] {
        
        let characters: [MarvelCharacter] = array.map { dto in
            return dto.toDomain()
        }
        return characters
    }
}

protocol MarvelCharactersViewModelProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    
    func didFetchCharacters()
    func didFailToFetchCharacters()
}
