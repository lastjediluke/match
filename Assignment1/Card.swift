//
//  Card.swift
//  Assignment1
//
//  Created by Luke Dillon on 8/29/18.
//  Copyright © 2018 Luke Dillon. All rights reserved.
//

import Foundation

//struct is pass by value (copied)
//strings, arrays, ints, etc are structs
//class is reference type
//struct has no inheritance

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    static var identifierFactory = 0    //what is static
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
        //I removed Card because it's a static
    }
    
    //static cannot be sent to a card, so to access it, you need to do Card.identifierFactory
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
        //self.identifier = identifier
    }
    
    //usually inits have the same internal and external name
    
}
