//
//  CardShape.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 8/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct CardShape: ViewModifier, AnimatableModifier {
    init(isFaceUp: Bool) {
        rotationAngle = isFaceUp ? 0 : 180
    }
    
    var rotationAngle: Double
    
    var animatableData: Double {
        get { rotationAngle }
        
        set { rotationAngle = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            
            if rotationAngle < 90 {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                    .foregroundColor(.blue)
                
                content
            } else {
                shape.fill(.blue)
                    .opacity(rotationAngle < 90 ? 0 : 1)
            }
        }
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    
    func cardShape(isFaceUp: Bool) -> some View {
        modifier(CardShape(isFaceUp: isFaceUp))
    }
}
