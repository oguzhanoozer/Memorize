//
//  Cardify.swift
//  Memorize
//
//  Created by oguzhan on 27.09.2024.
//

import Foundation
import SwiftUI

struct Cardify: ViewModifier, Animatable{

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180

    }

    var isFaceUp: Bool{
        return rotation < 90
    }

    var rotation: Double

    var animatableData: Double{
        get { rotation }
        set { rotation = newValue }
    }

    func body(content: Content) -> some View {
        return ZStack{
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(style: StrokeStyle(lineWidth: Constants.lineWidth))
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),
                                  axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }

}


extension View{
    func cardify(isFaceUp: Bool) -> some View{
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

