//
//  MarvelCharactersViewController.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import UIKit

class MarvelCharactersViewController: BaseViewController {
    
    private var viewModel: MarvelCharatersViewModel!
    @IBOutlet weak var marvelCharactersTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.fetchCharacters()
    }
    
    override func setupInterface() {
        super.setupInterface()
        title = "Marvel Characters"
        setupTableView()
    }
    
    func setupTableView() {
        let marvelCharacterTableCell = UINib(nibName: "MarvelCharacterTableCell", bundle: nil)
        marvelCharactersTableView.register(marvelCharacterTableCell, forCellReuseIdentifier: "MarvelCharacterTableCell")
        
        let loadMoreTableCell = UINib(nibName: "LoadMoreTableCell", bundle: nil)
        marvelCharactersTableView.register(loadMoreTableCell, forCellReuseIdentifier: "LoadMoreTableCell")
        
        marvelCharactersTableView.showsVerticalScrollIndicator = false
        marvelCharactersTableView.dataSource = self
    }
    
    func setupViewModel() {
        viewModel = MarvelCharatersViewModel()
        viewModel.delegate = self
    }
}

extension MarvelCharactersViewController: MarvelCharactersViewModelProtocol {
    func showLoader() {
        ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
    }
    
    func hideLoader() {
        ActivityIndicator.sharedIndicator.hideActivityIndicator()
    }
    
    func didFetchCharacters() {
        marvelCharactersTableView.reloadData()
    }
    
    func didFailToFetchCharacters() {
        #warning("Show Popup")
    }
}

extension MarvelCharactersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.hasMore == true ? 2 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.charactersCount()
        } else if section == 1 && viewModel.hasMore {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let character = viewModel.charcterAt(index: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCharacterTableCell") as! MarvelCharacterTableCell
            cell.setup(title: character.name, thumbnailUrl: character.thumbnail?.getUrl(size: .standard_medium))
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableCell") as! LoadMoreTableCell
            cell.startLoading()
            cell.selectionStyle = .none
            viewModel.fetchCharacters()
            return cell
        }
    }
}
