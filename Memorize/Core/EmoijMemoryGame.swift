//
//  EmoijMemoryGame.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import Foundation

class EmoijMemoryGame: ObservableObject{
    private static let emojis = ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 16) { pairIndex in
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

    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }

    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }

    // MARK: Intents

    func shuffle(){
        model.shuffle()
//        objectWillChange.send()
    }
}


    //  {
    //    (index: Int) -> String in
    //    return ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"][index]
    //  }

    //{
    //    (index) in
    //    return ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"][index]
    //}

    //index in
    //return ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"][index]
    //}

    //  cardContentFactory: (Int) -> CardContent

    //func createCardContent(forPairAtIndex index: Int) -> String{
    //    return ["👻","🎃","🕷️","😈", "😱","☠️","😺","🤡","🕸️","🐙","🦀","🤖"][index]
    //}
