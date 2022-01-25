//
//  ContentView.swift
//  memorize
//
//  Created by 李旭 on 2022/1/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var  viewModel : EmojiMemoryGame;
     
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 75, maximum: 100))])  {
                    ForEach(viewModel.cards){ card in
                        Card(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card )

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
    var card : MemoryGame<String>.Card;

    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 16)
            if(card.isFaceUp) {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 4)
                Text(card.content).font(.largeTitle)
            } else if (card.isMatched) {
                shape.opacity(0)
            }
            
            else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame();
        ContentView(viewModel: game).previewInterfaceOrientation(.portraitUpsideDown)
    }
}
