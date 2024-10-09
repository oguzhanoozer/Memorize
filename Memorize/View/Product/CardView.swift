//
//  CardView.swift
//  Memorize
//
//  Created by oguzhan on 27.09.2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: MemoryGame<String>.Card

    init(_ card: Card) {
        self.card = card
    }

    var body: some View {

        TimelineView(.animation) { timeline in // minimumInterval: 1/10
            if card.isFaceUp || !card.isMatched{
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    //                    .stroke(lineWidth: 6)
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale) // to remove cardview from UI View
            }
            else{
                Color.clear
            }
        }
    }

    var cardContents: some View{
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center )
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
}

extension Animation{
    static func spin(duration: TimeInterval) -> Animation{
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

#Preview {
    typealias Card = CardView.Card

    return CardView(Card(content: "X", id: "test1"))
        .padding()
        .foregroundStyle(.green)
}
