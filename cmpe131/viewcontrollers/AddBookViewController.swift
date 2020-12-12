//
//  addBookViewController.swift
//  cmpe131
//
//  Created by Yu Li on 12/12/20.
//

import Foundation
import UIKit

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var bookISBNTestField: UITextField!

    @IBOutlet weak var bookConditionTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
        }
        self.setUpElements()
    }
    
    func setUpElements(){
        // hide the error label
        errorLabel.alpha = 0
        Utilities.fillButton(button: submitButton)
    }
    
    func validateFields() -> String? {
        
        if bookTitleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bookISBNTestField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            bookConditionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || priceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }

    @IBAction func submitTapped(_ sender: Any) {
        // validate the fields

        let err = validateFields()
        
        if err != nil{
            self.showErr(err!)
        } else {
            errorLabel.alpha = 0
            
            // add book information to data base
            
            
            
            // Transit to book detail page
            self.transitToBookDetailPage()
            
        }
        
    }
    
    func showErr(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    func transitToBookDetailPage() {
        let bookDetailViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.bookDetailViewController) 
        
        view.window?.rootViewController = bookDetailViewController
        view.window?.makeKeyAndVisible()
    }
    
    
}
