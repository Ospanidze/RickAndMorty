//
//  ViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 20.03.2023.
//

import UIKit
import Alamofire

final class HeroListViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    
    private let searchController = UISearchController(searchResultsController: nil)
    
//    private var filteredCharacter: [Character] = []
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
    
    private var heroes: [Hero] = []
    
    //MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        //tableView.backgroundColor = .orange
        
        setupNavigationBar()
        setupSearchController()
        //fetchData(from: RickAndMortyAPI.baseURL.url)
        fetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? InfoViewController else { return
        }
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        let hero = heroes[indexPath.row]
        infoVC.hero = hero
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let hero = heroes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = hero.name
        content.secondaryText = hero.gender.rawValue
        
        AF.request(hero.image)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    content.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
        
        
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
        return cell

    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        80
//    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    private func setupNavigationBar() {
        title = "Rick and Morty"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func fetch() {
        networkManager.fetchPersona(from: Link.personeURL.url) {[weak self] result in
            switch result {
            case .success(let heroes):
                self?.heroes = heroes
                //print(heroes.count)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fecthData() {
        
    }
    
}

// MARK: - UISearchResultsUpdating
extension HeroListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }

    private func filterContentForSearchText(_ searchText: String) {
//        filteredCharacter = rickAndMorty?.results.filter { character in
//            character.name.lowercased().contains(searchText.lowercased())
//        } ?? []

        tableView.reloadData()
    }
}




