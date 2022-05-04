//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

struct MemoryGame {
    private(set) var cards: [Card]
    private(set) var difficulty: GameDifficulty
    private(set) var moveCounter: Int
    // Remaining pairs = total cards - matched cards
    var remainingPairsCounter: Int { cards.count - cards.filter { $0.isMatched }.count }
    
    init(difficulty: GameDifficulty) {
        self.cards = []
        self.difficulty = difficulty
        
        let numberOfPairsOfCards = (difficulty.numberOfRows * difficulty.numberOfColumns) / 2
        
        for i in 0..<numberOfPairsOfCards {
            cards.append(Card(id: i * 2, content: "\(i)"))
            cards.append(Card(id: i * 2 + 1, content: "\(i)"))
        }
        
        self.moveCounter = 0
    }
    
    struct Card {
        private let id: Int
        let content: String
        private(set) var isFaceUp = false
        private(set) var isMatched = false
        
        init(id: Int, content: String) {
            self.id = id
            self.content = content
        }
    }
    
    static let example = MemoryGame(difficulty: GameDifficulty.example)
}
