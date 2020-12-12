//
//  HomeViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/6/20.
//

import UIKit

class HomeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
    }
    
    
}
