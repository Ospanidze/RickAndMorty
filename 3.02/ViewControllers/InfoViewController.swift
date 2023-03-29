//
//  InfoViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 23.03.2023.
//

import UIKit
import Alamofire

final class InfoViewController: UIViewController {
    
    @IBOutlet var heroImageView: UIImageView!
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
        
        AF.request(hero?.image ?? "")
            .validate()
            .responseData { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    self?.heroImageView.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
