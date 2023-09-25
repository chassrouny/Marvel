//
//  MarvelDetail.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 25/09/2023.
//

import Foundation
import UIKit

enum MarvelDetailState {
    case loading
    case empty
    case loaded
    case failed
}

enum MarvelDetailType {
    case comics
    case events
    case series
    case stories
}

class MarvelDetail {
    var title: String
    var state: MarvelDetailState = .loading
    var type: MarvelDetailType = .comics
    
    init(type: MarvelDetailType, title: String, state: MarvelDetailState) {
        self.title = title
        self.state = state
        self.type = type
    }
    
    func layout() -> NSCollectionLayoutSection  {
        switch state {
        case .loading:
            return loadingLayout
        case .empty:
            return emptyLayout
        case .loaded:
            switch type {
            case .comics:
                return comicsLayout
            case .events:
                return eventsLayout
            case .series:
                return seriesLayout
            case .stories:
                return storiesLayout
            }
        case .failed:
            return emptyLayout
        }
    }
    
    private var loadingLayout: NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(30))
        return section(groupSize: groupSize)
    }
    
    private var emptyLayout: NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(30))
        return section(groupSize: groupSize)
    }
    
    
    private var comicsLayout: NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                               heightDimension: .absolute(300))
        return section(groupSize: groupSize)
    }
    
    private var eventsLayout: NSCollectionLayoutSection {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(250),
                                               heightDimension: .absolute(250))
        return section(groupSize: groupSize)
    }
    
    private var seriesLayout: NSCollectionLayoutSection {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                               heightDimension: .absolute(200))
        return section(groupSize: groupSize)
    }
    
    private var storiesLayout: NSCollectionLayoutSection {
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(125),
                                               heightDimension: .absolute(50))
        return section(groupSize: groupSize)
    }
    
    private func section(groupSize: NSCollectionLayoutSize) -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(30.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
