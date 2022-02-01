//
//  ContentView.swift
//  memorize
//
//  Created by 李旭 on 2022/1/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var  game : EmojiMemoryGame;
     
    var body: some View {
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            })
            .padding(.horizontal)
            .foregroundColor(.red)
    }

    
}


struct CardView: View {
    var card : EmojiMemoryGame.Card;
   
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingContents.cornerRadius)
                if(card.isFaceUp) {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingContents.lineWidth)
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if (card.isMatched) {
                    shape.opacity(0)
                }
                
                else {
                    shape.fill()
                }
            }
        }
        
    }
    
    private func font(in size:CGSize) -> Font {
        Font.system(size:  min(size.height, size.width) * DrawingContents.fontScale)
    }
    
    private struct DrawingContents {
        static let cornerRadius: CGFloat = 16
        static let lineWidth: CGFloat = 4
        static let fontScale: CGFloat = 0.8
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        EmojiMemoryGameView(game: game).previewInterfaceOrientation(.portrait)
    }
}
