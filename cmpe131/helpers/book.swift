//
//  book.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/9/20.
//

import Foundation

class book{
    var title: String!
    var isbn: String!
    var imageName: String!
    var condition: String!
    var price: String!
    var docID: String!
    
    public init(title:String, isbn:String,imageName:String, condition:String, price:String, docID:String){
        self.title = title
        self.isbn = isbn
        self.imageName = imageName
        self.condition = condition
        self.price = price
        self.docID = docID
    }
}
