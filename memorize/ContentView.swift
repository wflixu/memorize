//
//  ContentView.swift
//  memorize
//
//  Created by 李旭 on 2022/1/22.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🍏", "🍐", "🍊", "🍇", "🍋", "🍅", "🍍", "🥑", "🥭", "🍉", "🥜", "🌰", "🍩"]
    
    @State var count = 4
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 75, maximum: 100))])  {
                    ForEach(emojis[0..<count], id: \.self){ emoji in
                        Card(content:emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
          
            .padding().foregroundColor(.red)
            
            HStack {
                Button(action:{
                    if count > 1 {
                        count = count - 1
                    }
                   
                },label:{
                    Image(systemName: "minus.circle")
                })
                Spacer()
                Button(action:{
                    if count < emojis.count {
                        count = count + 1
                    }
                   
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
            .padding(.horizontal, 22.0)
            .font(.largeTitle)
        }
       
    }
}


struct Card: View {
    var content: String = "dd";
    @State var isUp: Bool = true;
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 16)
            if(isUp) {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 4)
                Text(content).font(.largeTitle)
            }else {
                shape.fill()
            }
        }
        .onTapGesture {
            isUp = !isUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
