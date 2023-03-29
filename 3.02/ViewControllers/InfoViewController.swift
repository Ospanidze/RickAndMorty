//
//  InfoViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 23.03.2023.
//

import UIKit
import Alamofire

final class InfoViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = heroImageView.frame.width / 2
        }
    }
    @IBOutlet var descriptionLabel: UILabel!
    
    var hero: Hero?
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero?.name
        descriptionLabel.text = hero?.fullInfo
        fetchImage()
    }
    
    private func fetchImage() {
        networkManager.fetchImage(from: hero?.image ?? "") { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.heroImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
