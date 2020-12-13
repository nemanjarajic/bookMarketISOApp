//
//  searchViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/7/20.
//

import UIKit
import Firebase

enum selectedSearch:Int{
    case title = 0
    case isbn = 1
}


class searchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        getBooks()
        searchBarSetUp()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Search Bar Code
    //Tap on screen closes keyboard
    var filteredBooks: [book]?
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSetUp(){
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Title", "ISBN"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            filteredBooks = bookList
        }else{
            filterTableView(sFilter: searchBar.selectedScopeButtonIndex, text: searchText)
        }
        print(searchText)
        tableView.reloadData()
    }
    
    
    
    func filterTableView(sFilter: Int, text: String){
    
        
        switch sFilter {
        case selectedSearch.title.rawValue:
            filteredBooks = bookList.filter { (mod) -> Bool in
                return mod.title.lowercased().contains(text.lowercased())
            }
        case selectedSearch.isbn.rawValue:
            filteredBooks = bookList.filter { (mod) -> Bool in
                return mod.isbn.contains(text.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789").inverted))
            }
        
        default:
            print("search filter default")
        }
    }
    
    //Retrive and append books into list
    //Code for filling Tableview with books from database
    var bookList = [book]()
    
    func getBooks(){
        let db = Firestore.firestore()
        let docRef = db.collection("books")
        docRef.getDocuments { (snapshot, err) in
            if err != nil{
                print("error in accessing data")
            }else{
                
                for item in snapshot!.documents{
                    var image = ""
                    if item.data()["image"] == nil{
                        image = "defualt"
                    }else{
                        image = item.data()["image"] as! String
                    }
                    let newBook = book(title: item.data()["title"] as! String, isbn: item.data()["isbn"] as! String, imageName: image, condition: item.data()["condition"]as! String, price: item.data()["price"] as! String)
                    self.bookList.append(newBook)
                }
                
            }
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredBooks == nil{
            return bookList.count
            
        }else{
            
            return filteredBooks!.count
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableVC = tableView.dequeueReusableCell(withIdentifier: "tableVCID") as! tableViewCell
        let thisBook: book!
        
        //print(filteredBooks?.count)
        if filteredBooks == nil{
            thisBook = bookList[indexPath.row]
        }else{
            thisBook = filteredBooks![indexPath.row]
        }
        
        tableVC.bookTitle.alpha = 1
        tableVC.bookTitle.text = thisBook.title
        
        tableVC.bookDescription.alpha = 1
        tableVC.bookDescription.text = "ISBN:" + thisBook.isbn
        
        tableVC.bookImage.image = UIImage (named: thisBook.imageName)
        
        return tableVC
    }
    
    
    //Code for segue to detailViewController that displays all books for sale
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? forSaleViewController
            
            let selectedBook = bookList[indexPath.row]
            
            tableViewDetail!.selectedBook = selectedBook
            
            self.tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }

}
