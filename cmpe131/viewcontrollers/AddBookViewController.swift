//
//  addBookViewController.swift
//  cmpe131
//
//  Created by Yu Li on 12/12/20.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var bookAuthorTextField: UITextField!
   
    @IBOutlet weak var bookYearTextField: UITextField!
    
    @IBOutlet weak var bookISBNTestField: UITextField!

    @IBOutlet weak var bookConditionTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // initialize the page
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
        }
        self.setUpElements()
        bookTitleTextField.delegate = self
        bookAuthorTextField.delegate = self
        bookYearTextField.delegate = self
        bookISBNTestField.delegate = self
        bookConditionTextField.delegate = self
        priceTextField.delegate = self
        
        
    }
    
    // formatting the page
    func setUpElements(){
        // hide the error label
        errorLabel.alpha = 0
        Utilities.fillButton(button: submitButton)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    // check if the user enters the valid inputs
    func validateFields() -> String? {
        
        if bookTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bookAuthorTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bookYearTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bookISBNTestField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bookConditionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || priceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }

    // save the entered input of the book to the database
    @IBAction func submitTapped(_ sender: Any) {
        // validate the fields

        let err = validateFields()
        
        if err != nil{
            self.showErr(err!)
        } else {
            errorLabel.alpha = 0
            
            // add book information to data base
            let BT = bookTitleTextField.text!
            let BAuthor = bookAuthorTextField.text!
            let BYear = bookYearTextField.text!
            let ISBN = bookISBNTestField.text!
            let BCond = bookConditionTextField.text!
            let BPrice = priceTextField.text!
            
            let db = Firestore.firestore()
            
            let user = Auth.auth().currentUser

            db.collection("books").document(ISBN).setData([
                "title": BT,
                "author": BAuthor,
                "year": BYear,
                "isbn": ISBN,
                "condition": BCond,
                "price": BPrice,
                "uid": user!.uid,
                "image": "no_image"
            ]) {
                err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            // Transit to book detail page
            self.transitToSuccessPage()
        }
        
    }
    
    // prompt error message
    func showErr(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    // function go to the list success view controller
    func transitToSuccessPage() {
        let listSuccessViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.listSuccessViewController)
        
        view.window?.rootViewController = listSuccessViewController
        view.window?.makeKeyAndVisible()
    }

}
