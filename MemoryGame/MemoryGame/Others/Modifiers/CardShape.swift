//
//  CardShape.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 8/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct CardShape: ViewModifier, AnimatableModifier {
    
    var color: Gradient
    
    var rotationAngle: Double
    
    var animatableData: Double {
        get { rotationAngle }
        
        set { rotationAngle = newValue }
    }
    
    init(isFaceUp: Bool, color: Gradient) {
        self.rotationAngle = isFaceUp ? 0 : 180
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            let linearGradient = LinearGradient(gradient: color, startPoint: .top, endPoint: .bottom)
            
            if rotationAngle < 90 {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                    .foregroundStyle(linearGradient)
                
                content
            } else {
                shape.fill(linearGradient)
                    .opacity(rotationAngle < 90 ? 0 : 1)
            }
        }
        .rotation3DEffect(Angle(degrees: rotationAngle), axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    
    func cardShape(isFaceUp: Bool, color: Gradient) -> some View {
        modifier(CardShape(isFaceUp: isFaceUp, color: color))
    }
}
