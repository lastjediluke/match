//
//  concentration.swift
//  Assignment1
//
//  Created by Luke Dillon on 8/29/18.
//  Copyright © 2018 Luke Dillon. All rights reserved.
//

import Foundation
//method is like a function
//api is like a function, how you use a class

//class is pass by reference
class concentration {   //this is the model
    var cards = Array<Card>()   //the () initializes the array to empty
    //or var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?   //if set, its an int. if not, its nil
    
    func chooseCard(at index: Int){     //when i choose a card, i choose it by index
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false   //turns cards face down
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int){
        //var unShuffledCards: [Card] = []
        //underscore means I don't care what this variable is
        //for identifier in 0..<numberOfPairsOfCards{
            //let card = Card(identifier: identifier)
            /*matching card is copy of card */
            //cards.append(card)
            //cards.append(card)

        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            //unShuffledCards += [card, card]
            cards += [card, card]
            
        }
        
//        while !unShuffledCards.isEmpty {
//            let randomIndex = unShuffledCards.count.arc4Random
//            let card = unShuffledCards.remove(at: randomIndex)
//            cards.append(card)
//        }
    }
    
    //TODO
    //shuffle the cards
    
}
