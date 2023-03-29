//
//  TableView.swift
//  3.02
//
//  Created by Айдар Оспанов on 29.03.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.contentMode = .scaleAspectFit
            heroImageView.clipsToBounds = true
            heroImageView.layer.cornerRadius = heroImageView.frame.width / 2
            heroImageView.backgroundColor = .white
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods
    
    func configure(with hero: Hero?) {
        guard let hero = hero else { return }
        nameLabel.text = hero.description
        networkManager.fetchImage(from: hero.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.heroImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
