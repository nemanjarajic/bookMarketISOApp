//
//  Utilities.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/6/20.
//

import Foundation
import UIKit

class Utilities{
    
    static func styleTextField(text : UITextField){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: text.frame.height - 2, width: text.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 0, green: 104/255, blue: 172/255, alpha: 1).cgColor
        text.borderStyle = .none
        text.layer.addSublayer(bottomLine)
        
    }
    
    static func fillButton(button:UIButton){
        button.backgroundColor = UIColor.init(red: 0/255, green: 104/255, blue: 172/255, alpha: 1)
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
    }
    
    //Password must contain at least one capital letter and minimum of 8 characters long
    static func isValidPassword(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
}
