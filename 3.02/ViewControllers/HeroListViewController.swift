//
//  ViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 20.03.2023.
//

import UIKit

final class HeroListViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
    
    private var heroes: [Hero] = []
    
    //MARK: Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHero()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoVC = segue.destination as? InfoViewController 
        infoVC?.hero = sender as? Hero
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        guard let cell = cell as? UserActionCell else {
            return UICollectionViewCell()
        }
        
        let persone = heroes[indexPath.item]
        cell.configure(model: persone)
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

//MARK: UICollectionViewDelegate

extension HeroListViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = heroes[indexPath.item]
        performSegue(withIdentifier: "showInfo", sender: hero)
    }
}

//MARK: NetworkManager

extension HeroListViewController {
    private func fetchHero() {
        networkManager.fetchPersone(from: Link.personeURL.url) { [weak self] result in
            switch result {
            case .success(let persone):
                self?.heroes = persone.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
