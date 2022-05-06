//
//  MemoryGameView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var gameViewModel: MemoryGameViewModel
    @Environment(\.dismiss) var dismiss
    
    init(game: MemoryGame, theme: Theme) {
        let viewModel = MemoryGameViewModel(memoryGame: game, theme: theme)
        self._gameViewModel = ObservedObject(initialValue: viewModel)
    }
    
    var body: some View {
        VStack {
            // Top information
            HStack {
                remainingPairsCounter
                Spacer()
                timeCounter
            }
            
            // Card Grid
            ScrollView {
                cardGrid
            }

            // Bottom - actions
            HStack {
                backButton
                Spacer()
                moveCountLabel
                Spacer()
                giveUpButton
            }
            .padding()
        }
        .padding()
        .navigationTitle(gameViewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView(game: .example, theme: .example)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE 3"))
        MemoryGameView(game: .example, theme: .example)
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}

extension MemoryGameView {
    
    var remainingPairsCounter: some View {
        Text("Remaining pairs: \(gameViewModel.remainingPairsCount)")
    }
    
    var timeCounter: some View {
        TimerView(id: "MemoryGame", minutes: 1, seconds: 0)
            .equatable()
    }
    
    // MARK: - Card Grid -
    var cardGrid: some View {
        LazyVGrid(columns: Array.init(repeating: GridItem(), count: gameViewModel.gameDifficulty.numberOfColumns)) {
            ForEach(gameViewModel.cards, id: \.id) { card in
                GeometryReader { geometry in
                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        
                        if card.isFaceUp || card.isMatched {
                            shape.fill(.white)
                            shape.strokeBorder(lineWidth: 3)
                                .foregroundColor(.blue)
                            Text(String(card.content))
                                .font(.system(size: geometry.size.width * 0.7))
                        } else {
                            shape.fill(.blue)
                        }
                    }
                    .onTapGesture { gameViewModel.select(card) }
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    // MARK: - Buttons and move count -
    var backButton: some View {
        Button("Go back") { dismiss() }
    }
    
    var moveCountLabel: some View {
        Text("Moves: **\(gameViewModel.moveCount)**")
    }
    
    var giveUpButton: some View {
        Button("Give up", role: .destructive) { }
    }
}
