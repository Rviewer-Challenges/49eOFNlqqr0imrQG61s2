//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 4/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

class MemoryGameViewModel: ObservableObject {
    @Published private var memoryGame: MemoryGame
    private let theme: Theme
    
    var cards: [MemoryGame.Card] {  memoryGame.cards }
    
    var remainingPairsCount: Int { memoryGame.remainingPairsCount }
    var moveCount: Int { memoryGame.moveCount }
    
    var gameDifficulty: GameDifficulty { memoryGame.difficulty }
    var title: String { theme.title }
    
    init(memoryGame: MemoryGame, theme: Theme) {
        self.memoryGame = memoryGame
        self.theme = theme
    }
    
    func select(_ card: MemoryGame.Card) {
        memoryGame.select(card)
    }
    
    func revealAllCards() {
        memoryGame.revealAllCards()
    }
    
    func restart() {
        memoryGame.restart()
    }
}
