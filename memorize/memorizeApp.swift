//
//  memorizeApp.swift
//  memorize
//
//  Created by 李旭 on 2022/1/22.
//

import SwiftUI

@main
struct memorizeApp: App {
    let game = EmojiMemoryGame();
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
