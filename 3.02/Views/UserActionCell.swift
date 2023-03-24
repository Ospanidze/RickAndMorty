//
//  UserActionCell.swift
//  3.02
//
//  Created by Айдар Оспанов on 20.03.2023.
//

import UIKit

final class UserActionCell: UICollectionViewCell {
    
    @IBOutlet var userLabel: UILabel!
    
    func configure(model: Hero) {
        userLabel.text = model.description
    }
    
}
