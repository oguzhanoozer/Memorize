//
//  MemorizeApp.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {

    @StateObject var game = EmoijMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
