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
    
    var cards: [MemoryGame.Card] {  memoryGame.cards }
    var remainingPairsCount: Int { memoryGame.remainingPairsCount }
    
    init() {
        memoryGame = MemoryGame(difficulty: .example)
    }
    
    func select(_ card: MemoryGame.Card) {
        memoryGame.select(card)
    }
}
