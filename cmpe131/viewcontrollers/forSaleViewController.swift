//
//  forSaleViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/10/20.
//

import UIKit
import Firebase

class forSaleViewController: UIViewController{
    
    
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    

    var selectedBook: book!
    
    @IBOutlet weak var sellerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        getSellers()
        setUpElement()
    }
    
    func setUpElement(){
        Utilities.fillButton(button: purchaseButton)
    }
    func getSellers(){
        bookTitle.text = selectedBook.title
        bookImage.image = UIImage (named: selectedBook.imageName)
        conditionLabel.text = "Condition: " + selectedBook.condition
        priceLabel.text = "Price: $" + selectedBook.price
            
    }
    
    
    
}
