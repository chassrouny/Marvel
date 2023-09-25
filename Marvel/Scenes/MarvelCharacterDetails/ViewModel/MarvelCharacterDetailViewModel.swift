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
    
    private var sections: [MarvelDetail] = [
        MarvelDetail(type: .comics, title: "Comics", state: .loading),
        MarvelDetail(type: .events, title: "Events", state: .loading),
        MarvelDetail(type: .series, title: "Series", state: .loading),
        MarvelDetail(type: .stories, title: "Stories", state: .loading)
    ]
    
    private var comics: [MarvelComic] = []
    private var events: [MarvelEvent] = []
    private var series: [MarvelSeries] = []
    private var stories: [MarvelStory] = []
    
    required init(characterId: Int) {
        self.characterId = characterId
        repository = MarvelCharacterDetailsRepository()
    }
    
    func reset() {
        for section in sections {
            section.state = .loading
        }
        
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
            let section = sections[0]
            if let comicsResponse = await repository.getComics(characterId: characterId) {
                if let its = comicsResponse.data.results, its.count > 0 {
                    let mappedComics = its.map { dto in return dto.toDomain()}
                    comics.removeAll()
                    comics.append(contentsOf: mappedComics)
                }
                section.state = comics.count == 0 ? .empty : .loaded
            } else {
                section.state = .failed
            }
            DispatchQueue.main.async {
                self.delegate?.didChangeData()
            }
        }
    }
    
    private func fetchEvents() {
        Task {
            let section = sections[1]
            if let eventsReponse = await repository.getEvents(characterId: characterId) {
                if let its = eventsReponse.data.results, its.count > 0 {
                    let mappedEvents = its.map { dto in return dto.toDomain()}
                    events.removeAll()
                    events.append(contentsOf: mappedEvents)
                }
                section.state = events.count == 0 ? .empty : .loaded
            } else {
                section.state = .failed
            }
            DispatchQueue.main.async {
                self.delegate?.didChangeData()
            }
        }
    }
    
    private func fetchSeries() {
        Task {
            let section = sections[2]
            if let seriesResponse = await repository.getSeries(characterId: characterId) {
                if let its = seriesResponse.data.results, its.count > 0 {
                    let mappedSeries = its.map { dto in return dto.toDomain()}
                    series.removeAll()
                    series.append(contentsOf: mappedSeries)
                }
                section.state = series.count == 0 ? .empty : .loaded
            } else {
                section.state = .failed
            }
            DispatchQueue.main.async {
                self.delegate?.didChangeData()
            }
        }
    }
    
    private func fetchStories() {
        Task {
            let section = sections[3]
            if let storiesResponse = await repository.getStories(characterId: characterId) {
                if let its = storiesResponse.data.results, its.count > 0 {
                    let mappedStories = its.map { dto in return dto.toDomain()}
                    stories.removeAll()
                    stories.append(contentsOf: mappedStories)
                }
                section.state = stories.count == 0 ? .empty : .loaded
            } else {
                section.state = .failed
            }
            DispatchQueue.main.async {
                self.delegate?.didChangeData()
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
    
    func sectionsCount() -> Int {
        sections.count
    }
    
    func sectionAt(index: Int) -> MarvelDetail {
        return sections[index]
    }
    
}

protocol MarvelCharacterDetailsViewModelProtocol: AnyObject {
    func didChangeData()
    
}
