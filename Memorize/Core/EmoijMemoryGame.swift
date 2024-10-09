//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import Foundation
import SwiftUI

class EmoijMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card

    private static let emojis = ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else{
                return "‼️"
            }
        }
    }

//    var objectWillChange: ObservableObjectPublisher

    @Published private var model = createMemoryGame()

    var cards: Array<Card>{
         model.cards
    }

    var color: Color{
        .orange
    }

    func choose(_ card: Card){
        model.choose(card)
    }

    var score: Int{
        model.score
    }

    // MARK: Intents
    func shuffle(){
        model.shuffle()
//        objectWillChange.send()
    }
    
}
