//
//  SelectionButton.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 10/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct SelectionButton: View {
    @State private var isBeingPressed = false
    @State private var yOffset: CGFloat = 0.0
    
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color(Constants.kBackgroundColor2)
            
            VStack(spacing: 10) {
                Text(icon)
                    .font(.title)
                
                Text(title)
            }
            .foregroundColor(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: isBeingPressed ? .clear : isSelected ? Color(Constants.kMainColor) : .black, radius: 4, x: 3, y: 5)
        .aspectRatio(1, contentMode: .fit)
        .offset(x: 0, y: yOffset)
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressed in
            action()
            isBeingPressed = pressed
            yOffset = pressed ? 4 : 0
        }, perform: { })
    }
}

struct SelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectionButton(icon: "🌼", title: "Plants", isSelected: true) { }
            .frame(width: 100, height: 100)
    }
}
