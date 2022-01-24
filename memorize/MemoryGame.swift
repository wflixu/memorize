//
//  MemoryGame.swift
//  memorize
//
//  Created by 李旭 on 2022/1/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private (set) var cards : Array<Card>;
    
    func choose(_ card:Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>();
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content:content))
            cards.append(Card(content:content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = true;
        var isMatched: Bool = false;
        var content: CardContent
    }
    
 
}
