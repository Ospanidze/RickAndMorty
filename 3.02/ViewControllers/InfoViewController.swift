//
//  InfoViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 23.03.2023.
//

import UIKit


final class InfoViewController: UIViewController {
    
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    var hero: Hero!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.name
        descriptionLabel.text = hero.fullInfo
        fetchImage()
    }
    
    private func fetchImage() {
        let urlString = hero.image 
        guard let url = URL(string: urlString) else {
            return
        }
        
        networkManager.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.heroImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
