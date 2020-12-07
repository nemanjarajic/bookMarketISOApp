//
//  loginViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/5/20.
//

import UIKit
import Firebase
import FirebaseAuth

class loginViewController: UIViewController{
    @IBOutlet weak var emailAddressIn: UITextField!
    @IBOutlet weak var passwordIn: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
    }
    
    func setUpElements(){
        Utilities.fillButton(button: signInButton)
        Utilities.styleTextField(text: emailAddressIn)
        Utilities.styleTextField(text: passwordIn)
    }
    @IBAction func signInClicked(_ sender: Any) {
        //validate fields
        
        //Sign in user
        let email = emailAddressIn.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = passwordIn.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: pwd) { (result,error) in
            
            if error != nil{
                self.errorMessage.text = "Error signing in"
            }else{
                self.transitionToHome()
            }
            
        }
        
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewContoller) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}