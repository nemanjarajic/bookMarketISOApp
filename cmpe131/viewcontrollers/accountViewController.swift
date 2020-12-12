//
//  accountViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/6/20.
//

import UIKit
import Firebase


class accountViewController: UIViewController{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        getUserInfor()
        Utilities.fillButton(button: signOutButton)
    }
    
    
    
    func getUserInfor(){
        
        let user = Auth.auth().currentUser
        self.emailLabel.text = user?.email
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: user?.uid).getDocuments(){(snapshot,err) in
            if err != nil {
                print("Error in getting data")
            }else{
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let FN = document.data()["first_Name"] as! String
                    let LN = document.data()["Last_Name"] as! String
                    self.nameLabel.text = FN + " " + LN
                    
                }
                    
            }
            
        }
        
    }
        
        
    
    
    func logout(){
        do{
            try Auth.auth().signOut()
        }catch let logoutError{
            print(logoutError)
        }
        
        print("Logout success full")
        
        let beginningVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.returnToLogin) as? ViewController
        view.window?.rootViewController = beginningVC
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        logout()
    }
    
    
}


