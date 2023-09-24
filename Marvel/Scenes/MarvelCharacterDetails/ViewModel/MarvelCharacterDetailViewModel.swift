//
//  MarvelCharacterDetailViewModel.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

class MarvelCharacterDetailsViewModel {
    private var repository: MarvelCharacterDetailsRepository
    weak var delegate: MarvelCharacterDetailsViewModelProtocol?
    
    private let characterId: Int
    
    var comics: [MarvelComic] = []
    var events: [MarvelEvent] = []
    var series: [MarvelSeries] = []
    var stories: [MarvelStory] = []
    
    required init(characterId: Int) {
        self.characterId = characterId
        repository = MarvelCharacterDetailsRepository()
    }
    
    func reset() {
        comics.removeAll()
        events.removeAll()
        series.removeAll()
        stories.removeAll()
    }
    
    func fetchAll() {
        fetchComics()
        fetchEvents()
        fetchSeries()
        fetchStories()
    }
    
    private func fetchComics() {
        Task {
            if let comicsResponse = await repository.getComics(characterId: characterId) {
                if let its = comicsResponse.data.results, its.count > 0 {
                    let mappedComics = its.map { dto in return dto.toDomain()}
                    comics.removeAll()
                    comics.append(contentsOf: mappedComics)
                }
                DispatchQueue.main.async {
                    self.delegate?.didFetchComics()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didFailToFetchComics()
                }
            }
        }
    }
    
    private func fetchEvents() {
        Task {
            if let eventsReponse = await repository.getEvents(characterId: characterId) {
                if let its = eventsReponse.data.results, its.count > 0 {
                    let mappedEvents = its.map { dto in return dto.toDomain()}
                    events.removeAll()
                    events.append(contentsOf: mappedEvents)
                }
                DispatchQueue.main.async {
                    self.delegate?.didFetchEvents()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didFailToFetchEvents()
                }
            }
        }
    }
    
    private func fetchSeries() {
        Task {
            if let seriesResponse = await repository.getSeries(characterId: characterId) {
                if let its = seriesResponse.data.results, its.count > 0 {
                    let mappedSeries = its.map { dto in return dto.toDomain()}
                    series.removeAll()
                    series.append(contentsOf: mappedSeries)
                }
                DispatchQueue.main.async {
                    self.delegate?.didFetchSeries()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didFailToFetchSeries()
                }
            }
        }
    }
    
    private func fetchStories() {
        Task {
            if let storiesResponse = await repository.getStories(characterId: characterId) {
                if let its = storiesResponse.data.results, its.count > 0 {
                    let mappedStories = its.map { dto in return dto.toDomain()}
                    stories.removeAll()
                    stories.append(contentsOf: mappedStories)
                }
                DispatchQueue.main.async {
                    self.delegate?.didFetchStories()
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didFailToFetchStories()
                }
            }
        }
    }
    
    func comicsCount() -> Int {
        return comics.count
    }
    
    func comicAt(index: Int) -> MarvelComic {
        return comics[index]
    }
    
    func eventsCount() -> Int {
        return events.count
    }
    
    func eventAt(index: Int) -> MarvelEvent {
        return events[index]
    }
    
    func seriesCount() -> Int {
        return series.count
    }
    
    func seriesAt(index: Int) -> MarvelSeries {
        return series[index]
    }
    
    func storiesCount() -> Int {
        return stories.count
    }
    
    func storyAt(index: Int) -> MarvelStory {
        return stories[index]
    }
    
}

protocol MarvelCharacterDetailsViewModelProtocol: AnyObject {
    func didFetchComics()
    func didFetchEvents()
    func didFetchStories()
    func didFetchSeries()
    func didFailToFetchComics()
    func didFailToFetchEvents()
    func didFailToFetchStories()
    func didFailToFetchSeries()
}

