//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by ζζ­ on 2022/1/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
   public typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["π", "βΊοΈ", "π₯°", "π", "π", "π¦", "π―", "π·", "π", "π", "π₯", "π¦", "πͺ°" ,"π" ,
                         "πͺ³","π¦","π¦","π","π¦§","π¦£","π","π¦₯","π¦¦","π¦«","π¦","π","π","π","π",
                         "π","π","β­οΈ"];
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8){ pairIndex in
            emojis[pairIndex];
        }
    }
    
   @Published private var model = createMemoryGame()
    
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle () {
        model.shuffle()
    }
    
    func restart () {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    
}
