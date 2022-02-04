//
//  MemoryGame.swift
//  memorize
//
//  Created by 李旭 on 2022/1/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private (set) var cards : Array<Card>;
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        set {
            cards.indices.forEach({index in cards[index].isFaceUp = (index == newValue)})
        }
    }
    
    mutating func choose(_ card: Card) {

        if  let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) ,
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
       
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>();
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content:content, id: pairIndex*2))
            cards.append(Card(content:content, id: pairIndex*2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
       
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                   startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        let id: Int;
        
        
        
        // Mark: - bonus time
        
        var bonusTimeLimit : TimeInterval = 6
        var lastFaceUpDate : Date?
        var pastFaceUpTime: TimeInterval = 0
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? (bonusTimeRemaining / bonusTimeLimit) : 0
        }
        
        var hasEarnedBonusTime: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        mutating func startUsingBonusTime () {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        mutating func stopUsingBonusTime () {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil 
        }
    }
    
 
}


extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
