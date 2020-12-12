//
//  forSaleViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/10/20.
//

import UIKit
import Firebase

class forSaleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var selectedBook: book!
    
    var bookForSale = [seller]()
    
    
    
    
    @IBOutlet weak var sellerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        getSellers()
    }
    
    func getSellers(){
        let temp = seller(title: "title", quality: "new", price: "price", email: "email")
        bookForSale.append(temp)
        let db = Firestore.firestore()
        let docRef = db.collection("books").document(selectedBook.isbn).collection("for_sale")
        
        docRef.getDocuments { (snapshot, err) in
            if err != nil{
                print("Error getting data")
            }else{
                for item in snapshot!.documents{
                    print(item)
                }
            }
        }
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookForSale.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableVC = tableView.dequeueReusableCell(withIdentifier: "detailVCID") as! detailTableView
        
        let thisBook = bookForSale[indexPath.row]
        tableVC.bookTitle.text = selectedBook.title
        
        return tableVC
    }
    
}
