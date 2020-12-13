//
//  EditBookViewController.swift
//  cmpe131
//
//  Created by Yu Li on 12/12/20.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class EditBookViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var bookAuthorTextField: UITextField!
    
    @IBOutlet weak var bookYearTextField: UITextField!
    
    @IBOutlet weak var bookISBNTextField: UITextField!
    
    @IBOutlet weak var bookConditionTextField: UITextField!
    
    @IBOutlet weak var bookPriceTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    var bookISBN = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
        }
    
        // Need to call function
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        let docRef = db.collection("books")
        
        // get information from database for current selected book
        docRef.getDocuments { (snapshot, err) in
            if err != nil{
                print("error in accessing data")
            }else{
                
                for item in snapshot!.documents{
                    if item.data()["uid"] as! String == user!.uid && item.data()["isbn"] as! String == self.bookISBN{
                        self.bookTitleTextField.text = item.data()["title"] as? String
                        self.bookAuthorTextField.text = item.data()["author"] as? String
                        self.bookYearTextField.text = item.data()["year"] as? String
                        self.bookISBNTextField.text = item.data()["isbn"] as? String
                        self.bookConditionTextField.text = item.data()["condition"] as? String
                        self.bookPriceTextField.text = item.data()["price"] as? String
                        break
                    }
                }
                
            }
            
        }
        self.setUpElements()
    }
    
    func setUpElements(){
        Utilities.fillButton(button: updateButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // save the updated book details to data base
    @IBAction func updateTapped(_ sender: Any) {
        let BT = bookTitleTextField.text!
        let BAuthor = bookAuthorTextField.text!
        let BYear = bookYearTextField.text!
        let ISBN = bookISBNTextField.text!
        let BCond = bookConditionTextField.text!
        let BPrice = bookPriceTextField.text!
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        db.collection("books").document(self.bookISBN).updateData([
            "title": BT,
            "author": BAuthor,
            "year": BYear,
            "isbn": ISBN,
            "condition": BCond,
            "price": BPrice,
            "uid": user!.uid,
            "image": "no_image"
        ])
        
        self.transitToSuccessPage()
    }
    
    func transitToSuccessPage() {
        let listSuccessViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.listSuccessViewController)
        
        view.window?.rootViewController = listSuccessViewController
        view.window?.makeKeyAndVisible()
    }
    
}
