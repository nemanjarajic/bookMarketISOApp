//
//  ListSuccessViewController.swift
//  cmpe131
//
//  Created by Yu Li on 12/12/20.
//

import Foundation
import UIKit

class ListSuccessViewController: UIViewController {
    
    
    @IBOutlet weak var backToHome: UIButton!
    
    // initialize the page
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
        }
        self.setUpElements()
    }
    
    // formatting the page
    func setUpElements(){
        // hide the error label
        Utilities.fillButton(button: backToHome)
    }
    
    @IBAction func BackToHomeTapped(_ sender: Any) {
        transitionToHome()
        
    }
    
    // go to home page
    func transitionToHome(){
        let appTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.appTabBarContoller) as? appTabBarController
        view.window?.rootViewController = appTabBarController
        view.window?.makeKeyAndVisible()
    }
}
