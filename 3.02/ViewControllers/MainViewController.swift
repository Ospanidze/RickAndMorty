//
//  MainViewController.swift
//  3.02
//
//  Created by Айдар Оспанов on 24.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = """
        if you wonder,
        how many characters in Ricky and Morty
        CLICK below
        """
    }
}
