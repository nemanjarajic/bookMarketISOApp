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
    
    public init(title:String, isbn:String,imageName:String){
        self.title = title
        self.isbn = isbn
        self.imageName = imageName
    }
}
