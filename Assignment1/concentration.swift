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
    var score = 0
    var flipCounter = 0
    
    static var matching = 20
    static var notMatching = -10
    
    func chooseCard(at index: Int){     //when i choose a card, i choose it by index
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += (concentration.matching)
                }
                else {
                    if cards[index].seen == true{
                        score += (concentration.notMatching)
                    }
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
        
        flipCounter += 1
    }
    
    init(numberOfPairsOfCards: Int){
        var unshuffled: [Card] = []
        //underscore means I don't care what this variable is
        //for identifier in 0..<numberOfPairsOfCards{
            //let card = Card(identifier: identifier)
            /*matching card is copy of card */
            //cards.append(card)
            //cards.append(card)

        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffled += [card, card]
            //cards += [card, card]
        }
        
        while !unshuffled.isEmpty {
            let randomIndex = unshuffled.count.random
            let card = unshuffled.remove(at: randomIndex)
            cards.append(card)
        }
    }
    
    //TODO
    //shuffle the cards
    
}
