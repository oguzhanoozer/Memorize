//
//  ContentView.swift
//  Memorize
//
//  Created by oguzhan on 24.09.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmoijMemoryGame

    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button{
                viewModel.shuffle()
            } label: {
                Text("Shuffle")
            }
        }
        .padding()
    }

    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }


    var body: some View {

        ZStack{
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group{
                base.fill(.white)
                base.strokeBorder(style: StrokeStyle(lineWidth: 2))
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
//            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity( card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmoijMemoryGame())
}
