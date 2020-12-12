//
//  createAccountViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/5/20.
//

import UIKit
import FirebaseAuth
import Firebase

class createAccountViewController: UIViewController{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
    }
    
    func setUpElements(){
        Utilities.styleTextField(text: firstName)
        Utilities.styleTextField(text: lastName)
        Utilities.styleTextField(text: emailAddress)
        Utilities.styleTextField(text: password)
        Utilities.styleTextField(text: confirmPassword)
        Utilities.fillButton(button: createAccount)
    }
    
    func validateField() -> String?{
        
        //Checks if all fields are filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        if password.text != confirmPassword.text{
            return "Passwords do not match"
        }
        
        let cleanPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidPassword(password: cleanPassword) == false{
            return "Password must contain a CAPITAL LETTER and be a minimum of 8 characters"
        }
        return nil
    }
    @IBAction func createAccountTapped(_ sender: Any) {
        let error = validateField()
        
        if error != nil{
            //There was an error inputing values
            errorLabel.text = error!
            errorLabel.alpha = 1
        }else{
            //Clean data
            let FN = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let LN = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pwd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create user in DB
            Auth.auth().createUser(withEmail: email, password: pwd) { (result, err) in
                if err != nil {
                    self.showError("Error in creating user")
                }else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first_Name": FN, "Last_Name": LN, "uid":result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("User data could not be stored")
                            
                        }
                    }
                }
            }
            
            errorLabel.text = ""
            //Homepage
            transitionToHome()
        }
    }
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let appTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.appTabBarContoller) as? appTabBarController
        view.window?.rootViewController = appTabBarController
        view.window?.makeKeyAndVisible()
    }
}
