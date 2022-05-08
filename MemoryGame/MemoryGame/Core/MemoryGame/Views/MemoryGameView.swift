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
    @ObservedObject var timer: GameTimer
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    
    init(game: MemoryGame, theme: Theme) {
        let gameVModel = MemoryGameViewModel(memoryGame: game, theme: theme)
        self._gameViewModel = ObservedObject(initialValue: gameVModel)
        
        let endTimeHander = gameVModel.revealAllCards
        let timerViewModel = GameTimer(minutes: 1, seconds: 0, endTimeHandler: endTimeHander)
        self._timer = ObservedObject(initialValue: timerViewModel)
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
        .onAppear {
            gameViewModel.restart()
            timer.reset(toMinutes: 1, seconds: 0)
        }
        .onChange(of: scenePhase) { newScene in
            if newScene == .active || newScene == .background {
                timer.pauseOrResume()
            }
        }
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
    
    // MARK: - Top Screen Information -
    var remainingPairsCounter: some View {
        Text("Remaining pairs: \(gameViewModel.remainingPairsCount)")
    }
    
    var timeCounter: some View {
        Text("\(timer.minutes) : \(String(format: "%02d", timer.seconds))")
            .foregroundColor(timer.timeIsCritical(underMinutes: 0, seconds: 10) ? .red : .green)
            .bold()
    }
    
    // MARK: - Card Grid -
    var cardGrid: some View {
        LazyVGrid(columns: Array.init(repeating: GridItem(), count: gameViewModel.gameDifficulty.numberOfColumns)) {
            ForEach(gameViewModel.cards, id: \.id) { card in
                GeometryReader { geometry in
                    Text(String(card.content))
                        .font(.system(size: geometry.size.width * 0.7))
                        .cardShape(isFaceUp: card.isFaceUp || card.isMatched)
                    .onTapGesture {
                        withAnimation {
                            gameViewModel.select(card)
                        }
                    }
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
