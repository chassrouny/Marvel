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
        fetchCharactersFromBackend(showLoader: !isSilent)
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
                            //Delete old Items from Cache
                            //Save Items to Cache
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
