//
//  MemoryGameView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct MemoryGameView: View {
    private let game: MemoryGame
    private let theme: Theme
    
    @Environment(\.dismiss) var dismiss
    @State private var remainingTime = 1
    
    init(game: MemoryGame, theme: Theme) {
        self.game = game
        self.theme = theme
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Number of pairs of cards: \(game.cards.count)")
            Spacer()
            Button("Volver al inicio", action: goBackToMenu)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
        }
        .padding()
        .navigationTitle(theme.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    func goBackToMenu() {
        dismiss()
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView(game: MemoryGame.example, theme: .pokemon)
    }
}
