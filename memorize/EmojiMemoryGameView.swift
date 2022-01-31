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
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 75, maximum: 100))])  {
                    ForEach(game.cards){ card in
                        Card(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card )

                            }
                    }
                }
            }.padding().foregroundColor(.red)
            
//            HStack {
//                Button(action:{
//                    if count > 1 {
//                        count = count - 1
//                    }
//
//                },label:{
//                    Image(systemName: "minus.circle")
//                })
//                Spacer()
//                Button(action:{
//                    if count < emojis.count {
//                        count = count + 1
//                    }
//
//                }, label: {
//                    Image(systemName: "plus.circle")
//                })
//            }
//            .padding(.horizontal, 22.0)
//            .font(.largeTitle)
        }
       
    }
}


struct Card: View {
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
