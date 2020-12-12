//
//  seller.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/11/20.
//

import Foundation

class seller{
    var title: String!
    var quality: String!
    var price: String!
    var email: String!
    
    public init(title: String, quality: String, price: String, email:String){
        self.title = title
        self.quality = quality
        self.price = price
        self.email = email
    }
}
