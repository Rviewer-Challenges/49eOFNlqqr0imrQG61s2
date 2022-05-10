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
    
    var gameIsOver: Bool { gameViewModel.remainingPairsCount == 0 || timer.timeIsUp }
    
    init(game: MemoryGame, theme: Theme) {
        let gameVModel = MemoryGameViewModel(memoryGame: game, theme: theme)
        self._gameViewModel = ObservedObject(initialValue: gameVModel)
        
        let endTimeHandler = gameVModel.endTimeHandler
        let timerViewModel = GameTimer(minutes: 1, seconds: 0, endTimeHandler: endTimeHandler)
        self._timer = ObservedObject(initialValue: timerViewModel)
    }
    
    var body: some View {
        ZStack {
            Color(Constants.kBackgroundColor)
                .ignoresSafeArea()
            
            VStack {
                // Card Grid
                ScrollView { cardGrid.padding(.top) }
                
                // Game info
                HStack {
                    remainingPairsCounter
                    Spacer()
                    moveCounter
                }
                .padding([.horizontal, .top], 4)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { backButton }
                ToolbarItem(placement: .navigationBarTrailing) { timeCounter }
            }
            .alert(gameViewModel.alertTitle, isPresented: $gameViewModel.showingAlert) {
                Button("Cancel", role: .cancel) { timer.pauseOrResume() }
                Button("Continue", role: .destructive, action: gameViewModel.alertOKAction)
            } message: {
                Text(gameViewModel.alertMessage)
            }
        }
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemoryGameView(game: .example, theme: .example)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE 3"))
        }
        
        NavigationView {
            MemoryGameView(game: .example, theme: .example)
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
        }
    }
}

extension MemoryGameView {
    
    // MARK: - Time Counter -
    var timeCounter: some View {
        TimerView(minutes: timer.minutes, seconds: timer.seconds, timeIsCritical: timer.timeIsCritical(underMinutes: 0, seconds: 10))
    }
    
    // MARK: - Card Grid -
    var cardGrid: some View {
        LazyVGrid(columns: Array.init(repeating: GridItem(), count: gameViewModel.gameDifficulty.numberOfColumns)) {
            ForEach(gameViewModel.cards, id: \.id) { card in
                GeometryReader { geometry in
                    Text(String(card.content))
                        .font(.system(size: geometry.size.width * 0.7))
                        .cardShape(isFaceUp: card.isFaceUp || card.isMatched, color: gameViewModel.cardColor)
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
    
    // MARK: - Back / Give Up Button -
    var backButton: some View {
        Button {
            if gameIsOver {
                dismiss()
            } else {
                timer.pauseOrResume()
                gameViewModel.giveUp {
                    dismiss()
                }
            }
        } label: {
            Text(gameIsOver ? "Back" : "Give up")
                .foregroundColor(gameIsOver ? .blue : .red)
                .bold()
        }
    }
    
    // MARK: - Bottom Screen Game Information -
    var remainingPairsCounter: some View {
        Text("Remaining pairs: \(gameViewModel.remainingPairsCount)")
    }
    
    var moveCounter: some View {
        Text("Moves: **\(gameViewModel.moveCount)**")
    }
}
