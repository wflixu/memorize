//
//  Cardify.swift
//  memorize
//
//  Created by 李旭 on 2022/2/2.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingContents.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingContents.lineWidth)
                content
            } else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingContents {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self .modifier(Cardify(isFaceUp: isFaceUp))
    }
}
