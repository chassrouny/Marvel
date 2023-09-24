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
        
        marvelCharactersTableView.dataSource = self
    }
    
    func setupViewModel() {
        viewModel = MarvelCharatersViewModel()
        viewModel.delegate = self
    }
}

extension MarvelCharactersViewController: MarvelCharactersViewModelProtocol {
    func showLoader() {
    }
    
    func hideLoader() {
    }
    
    func didFetchCharacters() {
        marvelCharactersTableView.reloadData()
    }
    
    func didFailToFetchCharacters() {
        #warning("Show Popup")
    }
}

extension MarvelCharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.charcterAt(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvelCharacterTableCell") as! MarvelCharacterTableCell
        cell.setup(title: character.name, thumbnailUrl: character.thumbnail?.getUrl(size: .standard_medium))
        cell.selectionStyle = .none
        return cell
    }
}
