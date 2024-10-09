//
//  ContentView.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmoijMemoryGame
    typealias Card = MemoryGame<String>.Card


    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let deckWidth: CGFloat = 50
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15

    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                cards
                    .foregroundStyle(viewModel.color)
            }
            HStack{
                score
                Spacer()
                deck.foregroundStyle(viewModel.color)
                Spacer()
                shuffle
            }.font(.largeTitle)
        }
        .padding()
    }

    private var score: some View{
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }

    private var shuffle: some View{
        Button{
            withAnimation(.interactiveSpring(response: 1, dampingFraction: 0.5)) {
                viewModel.shuffle()
            }
        } label: {
            Text("Shuffle")
        }
    }

//    @ViewBuilder
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) {card in
            if isDealt(card){
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.identity)
                    .padding(spacing)
                    .overlay(FliyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
//                    .transition(.offset(
//                        x: CGFloat.random(in: -1000...1000),
//                        y: CGFloat.random(in: -1000...1000)
//                    ))
            }
        }

//        .foregroundStyle(viewModel.color)
    }

    @State private  var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool{
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter {
            !isDealt($0)
        }
    }

    @Namespace private var dealingNamespace

    private var deck: some View{
        ZStack{
            ForEach(undealtCards){ card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))

//                    .transition(.offset(
//                        x: CGFloat.random(in: -1000...1000),
//                        y: CGFloat.random(in: -1000...1000)
//                    ))
            }
        }
        .frame(width: deckWidth, height:  deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }

    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }


    private func choose(_ card: Card){
        withAnimation(.easeInOut(duration: 1)){
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }


//    @State private var lastScoreChange:
//    (amount: Int, causedByCardId: Card.ID) = (amount: 0, causedByCardId: "")

    @State private var lastScoreChange = (amount: 0, causedByCardId: "")

    private func scoreChange(causedBy card: Card) -> Int{
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmoijMemoryGame())
}
