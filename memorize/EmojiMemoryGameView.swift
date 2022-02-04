//
//  ContentView.swift
//  memorize
//
//  Created by 李旭 on 2022/1/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var  game : EmojiMemoryGame;
    
    @Namespace private var dealingNamespace
    
     
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
            }
            deckBody
        }
        .padding()
        
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardContents.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardContents.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }

    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) ||  card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation  {
                            game.choose(card)
                        }
                        
                    }
            }
        }
        .padding(.horizontal)
        .foregroundColor(CardContents.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardContents.undealtWidth, height: CardContents.undealtHeight)
        .foregroundColor(CardContents.color)
        .onTapGesture {
          
            for card in game.cards {
                withAnimation (dealAnimation(for: card)) {
                        deal(card)
               }
                
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle"){
            withAnimation (.easeInOut(duration: 0.5)) {
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart"){
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardContents {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 3
        static let undealtHeight: CGFloat =  90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
    
}


struct CardView: View {
    var card : EmojiMemoryGame.Card;
    
    @State private var animatedBonusRemaining: Double = 0
   
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation (.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(5).opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360:0))
                    .animation(Animation.easeInOut(duration: 2))
                    .font(font(in: geometry.size))
           
            }.cardify(isFaceUp: card.isFaceUp)
        }
        
    }
    
    private func font(in size:CGSize) -> Font {
        Font.system(size:  min(size.height, size.width) * DrawingContents.fontScale)
    }
    
    private struct DrawingContents {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
