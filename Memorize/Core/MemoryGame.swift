//
//  MemorizeGame.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []

        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }

    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
                //            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
/*
            for index in cards.indices{
                if index == newValue{
                    cards[index].isFaceUp = true
                }else {
                    cards[index].isFaceUp = false
                }
            }
 */
    }

    mutating func choose(_ card: Card){
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }) {

            if !cards[choosenIndex].isFaceUp && !cards[choosenIndex].isMatched{
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{

                    if cards[choosenIndex].content == cards[potentialMatchIndex].content{
                        cards[choosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
//                    indexOfTheOneAndOnlyFaceUpCard = nil
                }else{
//                    for index in cards.indices{
//                        cards[index].isFaceUp = false
//                    }
                    indexOfTheOneAndOnlyFaceUpCard = choosenIndex
                    	
                }
                cards[choosenIndex].isFaceUp = true
            }
        }
    }

/*
    func index(of card: Card) -> Int?{
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
*/

    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomStringConvertible{
/*
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
        }
*/
        var isFaceUp = false
        var isMatched = false
        var content: CardContent

        var id: String

        var description: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }

    }
}

extension Array{
    var only: Element?{
        count == 1 ? first : nil
    }
}

/*

enum FastFoodMenuItem{
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie
}


enum FryOrderSize{
    case large
    case small
}


var menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)

func menuItemDebug(){
    switch menuItem {
        case .hamburger(let numberOfPatties):
            print("hamburger \(numberOfPatties)")
        case .fries(let size):
            print("fries \(size)")
        case .drink(let string, let ounces):
            print("drink \(string) \(ounces)")
        case .cookie:
            print("cookie")
                //        case FastFoodMenuItem.hamburger: print("")
                //        case FastFoodMenuItem.fries: print("")
                //        case FastFoodMenuItem.drink: print("")
                //        case FastFoodMenuItem.cookie: print("")
    }

}

*/
