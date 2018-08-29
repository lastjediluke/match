//
//  ViewController.swift
//  Assignment1
//
//  Created by Luke Dillon on 8/25/18.
//  Copyright © 2018 Luke Dillon. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!





    var emojiChoices = ["😀", "🚴", "😘", "😇"]

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            flipCard (withEmoji: emojiChoices[cardNumber], on: sender)
        }
        else
        {
            print ("Chosen card wasn't in cardbutton")
        }
    }
    

    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print ("flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }

    }
    
}

