//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 李旭 on 2022/1/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
   public typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["😀", "☺️", "🥰", "😉", "😋", "🦁", "🐯", "🐷", "🙉", "🐔", "🐥", "🦆", "🪰" ,"🐛" ,
                         "🪳","🦕","🦐","🐋","🦧","🦣","🐈","🦥","🦦","🦫","🦔","🍄","🌞","🌚","🌘",
                         "🌔","🌟","⭐️"];
    
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
}
