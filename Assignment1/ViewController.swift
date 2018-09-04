//
//  ViewController.swift
//  Assignment1
//
//  Created by Luke Dillon on 8/25/18.
//  Copyright © 2018 Luke Dillon. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    lazy var game = concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    //lazy just means it will initialize when it is called
    //classes get a free init as long as all the vars are initialized
    //didSet cannot be used with lazy
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //make sure buttons are connected
    @IBOutlet var cardButtons: [UIButton]!


    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
           // flipCard (withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else
        {
            print ("Chosen card wasn't in cardbutton")
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.4752156138, green: 0.8393645287, blue: 0.9762583375, alpha: 1)
                
            }
        }
    }
    
    var emojiChoices = ["😀", "🚴", "😘", "😇"]
    
    var emoji = [Int:String]()
    //var emoji = Dictionary<Int, String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))   //arcrandom is a random num generator
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)   //removes emoji from the array
        }
        return emoji[card.identifier] ?? "?"    //return emoji, but if it's not there, return ?
    }
}
    /* extension Int {
        var arc4Random: Int {
            switch self {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return Int(arc4random_uniform(UInt32(self)))
            default:
                return 0
            }
        }
    }
    
*/

