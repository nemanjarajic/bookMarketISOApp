//
//  purchaseSuccessful.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/12/20.
//

import UIKit

class purchaseSuccessful: UIViewController{
    
    
    @IBOutlet weak var returnHomeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        Utilities.fillButton(button: returnHomeButton)
    }
    
    
    func transitionToHome(){
        let appTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.appTabBarContoller) as? appTabBarController
        view.window?.rootViewController = appTabBarController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func returnHomeTapped(_ sender: Any) {
        transitionToHome()
    }
    
}
