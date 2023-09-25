//
//  MarvelCharacterDetailsViewController.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit

class MarvelCharacterDetailsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()

    
    private var viewModel: MarvelCharacterDetailsViewModel!
    var character: MarvelCharacter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        viewModel.fetchAll()
    }
    
    override func setupInterface() {
        super.setupInterface()
        self.title = character.name
        setupCollectionView()
    }
    
    deinit {
        debugPrint("DEINIT")
    }
    
    func setupCollectionView() {
        let headerCell = UINib(nibName: "HeaderCollectionCell", bundle: .main)
        collectionView.register(headerCell, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionCell")
        
        let imageTitleCell = UINib(nibName: "ImageTitleCollectionCell", bundle: .main)
        collectionView.register(imageTitleCell, forCellWithReuseIdentifier: "ImageTitleCollectionCell")
        
        let titleCell = UINib(nibName: "TitleCollectionCell", bundle: .main)
        collectionView.register(titleCell, forCellWithReuseIdentifier: "TitleCollectionCell")
        
        let emptyCell = UINib(nibName: "EmptyCollectionCell", bundle: .main)
        collectionView.register(emptyCell, forCellWithReuseIdentifier: "EmptyCollectionCell")
        
        let loadingCell = UINib(nibName: "LoadingCollectionCell", bundle: .main)
        collectionView.register(loadingCell, forCellWithReuseIdentifier: "LoadingCollectionCell")
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setCollectionViewLayout(compositionalLayout(), animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        viewModel.fetchAll()
    }
    
    private func compositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let this = self else { return .none }
            let section = this.viewModel.sectionAt(index: sectionIndex)
            return section.layout()
        }
    }
    
    func setupViewModel() {
        viewModel = MarvelCharacterDetailsViewModel(characterId: character.id)
        viewModel.delegate = self
    }
}

extension MarvelCharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sectionAt(index: section)
        switch section.state {
        case .loading, .empty, .failed:
            return 1
        case .loaded:
            switch section.type {
            case .comics:
                return viewModel.comicsCount()
            case .events:
                return viewModel.eventsCount()
            case .series:
                return viewModel.seriesCount()
            case .stories:
                return viewModel.storiesCount()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.sectionAt(index: indexPath.section)
        switch section.state {
        case .loading:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCollectionCell", for: indexPath) as! LoadingCollectionCell
            cell.setup()
            return cell
        case .empty, .failed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionCell", for: indexPath) as! EmptyCollectionCell
            cell.setup(text: section.state == .empty ? "No \(section.title) Available" : "Failed To Load \(section.title)")
            return cell
        case .loaded:
            var title: String?
            var imageUrl: String?
            switch section.type {
            case .comics:
                let comic = viewModel.comicAt(index: indexPath.item)
                title = comic.title
                imageUrl = comic.thumbnail?.getUrl(size: .portrait_uncanny)
            case .events:
                let event = viewModel.eventAt(index: indexPath.item)
                title = event.title
                imageUrl = event.thumbnail?.getUrl(size: .standard_fantastic)
            case .series:
                let series = viewModel.seriesAt(index: indexPath.item)
                title = series.title
                imageUrl = series.thumbnail?.getUrl(size: .standard_fantastic)
            case .stories:
                let story = viewModel.storyAt(index: indexPath.item)
                title = story.title
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionCell", for: indexPath) as! TitleCollectionCell
                cell.setup(title: title)
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTitleCollectionCell", for: indexPath) as! ImageTitleCollectionCell
            cell.setup(title: title, imageUrl: imageUrl)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = viewModel.sectionAt(index: indexPath.section)
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as! HeaderCollectionCell
        cell.setup(title: section.title)
        return cell
    }
}


extension MarvelCharacterDetailsViewController: MarvelCharacterDetailsViewModelProtocol {
    func didChangeData() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}
