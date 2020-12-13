//
//  ManageBookViewController.swift
//  cmpe131
//
//  Created by Yu Li on 12/12/20.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class ManageBookViewController: UIViewController {
    
    @IBOutlet weak var manageBookTable: UITableView!
    
    var bookISBN = ""
    
    var filteredBooks: [book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
        }
        
        manageBookTable.delegate = self
        manageBookTable.dataSource = self
        getBooks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var bookList = [book]()
    
    func getBooks(){
        let user = Auth.auth().currentUser;
        let db = Firestore.firestore()
        let docRef = db.collection("books")
        docRef.getDocuments { (snapshot, err) in
            if err != nil{
                print("error in accessing data")
            }else{
                
                for item in snapshot!.documents{
                    if item.data()["uid"] as! String != user!.uid {
                        continue
                    }
    
                    var image = ""
                    if item.data()["image"] == nil{
                        image = "defualt"
                    }else{
                        image = item.data()["image"] as! String
                    }
                    let newBook = book(title: item.data()["title"] as! String, isbn: item.data()["isbn"] as! String, imageName: image, condition: item.data()["condition"]as! String, price: item.data()["price"] as! String, docID: item.documentID)

                    self.bookList.append(newBook)
                }
                
            }
            self.manageBookTable.reloadData()
        }
    }
}

extension ManageBookViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("tapped")
        
        // Go to the book Modification page
        let thisBook: book!
        thisBook = bookList[indexPath.row]
        
        self.bookISBN = thisBook.isbn
        
        performSegue(withIdentifier: "editBook", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditBookViewController
        vc.bookISBN = self.bookISBN
        
    }
}

extension ManageBookViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableVC = tableView.dequeueReusableCell(withIdentifier: "tableVCID", for: indexPath) as! tableViewCell
        
        let thisBook: book!

        thisBook = bookList[indexPath.row]
        tableVC.bookTitle.alpha = 1
        tableVC.bookTitle.text = thisBook.title

        tableVC.bookDescription.alpha = 1
        tableVC.bookDescription.text = "ISBN:" + thisBook.isbn

        tableVC.bookImage.image = UIImage (named: thisBook.imageName)
        
        return tableVC
    }
}
