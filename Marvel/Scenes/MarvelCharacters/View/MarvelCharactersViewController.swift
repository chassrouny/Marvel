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
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.fetchCharacters(isSilent: false)
    }
    
    override func setupInterface() {
        super.setupInterface()
        title = "Marvel Characters"
        setupTableView()
    }
    
    func setupTableView() {
        marvelCharactersTableView.register(MarvelCharacterTableCell.nib, forCellReuseIdentifier: MarvelCharacterTableCell.identifier)
        marvelCharactersTableView.register(LoadMoreTableCell.nib, forCellReuseIdentifier: LoadMoreTableCell.identifier)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        marvelCharactersTableView.addSubview(refreshControl)
        
        
        marvelCharactersTableView.showsVerticalScrollIndicator = false
        marvelCharactersTableView.dataSource = self
        marvelCharactersTableView.delegate = self
        
    }
    
    func setupViewModel() {
        viewModel = MarvelCharatersViewModel()
        viewModel.delegate = self
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        viewModel.fetchCharacters(isSilent: true)
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
        refreshControl.endRefreshing()
    }
    
    func didFailToFetchCharacters() {
        let alert = UIAlertController(title: "Fail", message: "Error Loading Characters", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MarvelCharacterTableCell.identifier) as! MarvelCharacterTableCell
            cell.setup(title: character.name, thumbnailUrl: character.thumbnail?.getUrl(size: .standard_medium))
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableCell.identifier) as! LoadMoreTableCell
            cell.startLoading()
            cell.selectionStyle = .none
            viewModel.fetchCharacters(isSilent: true)
            return cell
        }
    }
}

extension MarvelCharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let character = viewModel.charcterAt(index: indexPath.row)
            let vc = MarvelCharacterDetailsRouter.characterDetailsVC(character: character)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
