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
    
    //var flipCount = 0
    /*{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    } */
    
    //var emojiChoices = ["😀", "🤓", "😘", "😇", "🙃", "🤪", "😢", "🤩", "😏", "🤨", "😤", "😱", "🙄"]
    
    typealias themeInfo = (emoji: [String], backgroundColor: UIColor, cardColor: UIColor)
    
    private let themes: [String: themeInfo] = [
        "faces": (["😀", "🤓", "😘", "😇", "🙃", "🤪", "😢", "🤩", "😏", "🤨", "😤", "😱", "🙄"], #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        "animals": (["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷"], #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
        "nature": (["🌵", "☘️", "🌲", "🌳", "🌴", "🌱", "🍃", "🌾", "💐", "🌹", "🌻", "🌸", "🍄"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        "sports": (["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "⛳️", "🥊"], #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
        "fruit": (["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍍", "🥥", "🥝"], #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
    ]
    
    private var newTheme: themeInfo {
        let randomIndex = themes.count.random
        let key = Array(themes.keys)[randomIndex]
        return themes[key]!
    }
    
    private var theme: themeInfo! {
        didSet {
            view.backgroundColor = theme.backgroundColor
            cardButtons.forEach {
                $0.backgroundColor = theme.cardColor
                $0.setTitle("", for: UIControlState.normal)
                //need to learn more about $
            }
            flipCountLabel.textColor = theme.cardColor
            scoreLabel.textColor = theme.cardColor
            //gameReset.textColor = theme.cardColor
            
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //make sure buttons are connected
    @IBOutlet var cardButtons: [UIButton]!

    @IBOutlet weak var gameReset: UIButton! {
        didSet {
            gameReset.titleLabel?.numberOfLines = 0
        }
    }
    
    @IBAction func onGameReset(_ sender: UIButton, forEvent event: UIEvent) {
        newGameStart()
    }
    
    private func newGameStart() {
        theme = newTheme
        game = concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: \(game.flipCounter)"
        scoreLabel.text = "Score: \(game.score)"
        emoji = [:]
        emojiChoices = theme.emoji
        
    }
    
    override func viewDidLoad() {
        newGameStart()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        //flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
           // flipCard (withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCountLabel.text = "Flips: \(game.flipCounter)"
            scoreLabel.text = "Score: \(game.score)"
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme.cardColor
                
            }
        }
    }
    
    
    
    private var emoji = [Int:String]()
    //var emoji = Dictionary<Int, String>()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))   //arcrandom is a random num generator
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)   //removes emoji from the array
        }
        return emoji[card.identifier] ?? "?"    //return emoji, but if it's not there, return ?
    }
    
    private lazy var emojiChoices: [String] = { return theme.emoji }()
    
    
    
}


    extension Int {
        var random: Int {
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
    


