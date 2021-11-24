//
//  ViewController.swift
//  Game
//
//  Created by smilegop on 29.03.2021.
//

import UIKit

class ViewController: UIViewController {

 private  lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
   private(set) var touches = 0 {
        didSet{
            touchLabel.text = "Нажатий: \(touches)"
            
        }
    }
    
   private var emojiDictionary = [Int:String]()

  private  var emojiCollection = ["🦊","🐭","🐶","🐱","🐻","🐷","🐸","🐯","🐨","🐓","🦌","🦦","🦀","🦐","🐠","🐅","🐊","🐄","🦢","🐬","🐞","🦄","🐥","🦇"]
   private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4randomExtension)
            
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    
  private  func updateVievFromModel() {
        for index  in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else {  button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

                
            }
        }
    }
    
    @IBOutlet  private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel!
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateVievFromModel()
        }
    }
    
}

    extension Int {
        var arc4randomExtension: Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self < 0 {
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else {
                return 0
                
            }
        }
    }


