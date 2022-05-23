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
    private(set) var moveCount: Int
    // Remaining pairs = total cards - matched cards
    var remainingPairsCount: Int { (cards.count - cards.filter { $0.isMatched }.count) / 2 }
    
    private var indexOfTheOnlySelectedCard: Int? {
        if cards.filter({ $0.isFaceUp }).count == 1, let index = cards.firstIndex(where: { $0.isFaceUp }) {
            return index
        }
        
        return nil
    }
    
    init(difficulty: GameDifficulty, contents: [String]) {
        let numberOfPairsOfCards = difficulty.numberOfPairsOfCards
                
        self.cards = []
        self.difficulty = difficulty
        
        for i in 0..<numberOfPairsOfCards {
            let content = contents[i]
            cards.append(Card(id: i * 2, content: content))
            cards.append(Card(id: i * 2 + 1, content: content))
        }
        
        cards.shuffle()
        
        self.moveCount = 0
    }
    
    mutating func select(_ card: Card) {
        if let selectedIndex = cards.firstIndex(of: card),
           !cards[selectedIndex].isMatched, !cards[selectedIndex].isFaceUp {
            
            if let indexOfTheOnlySelectedCard = indexOfTheOnlySelectedCard {
                moveCount += 1
                
                if cards[selectedIndex].content == cards[indexOfTheOnlySelectedCard].content {
                    cards[selectedIndex].isMatched = true
                    cards[indexOfTheOnlySelectedCard].isMatched = true
                }
            } else {
                for cardIndex in cards.indices {
                    cards[cardIndex].isFaceUp = false
                }
            }
            
            cards[selectedIndex].isFaceUp = true
        }
    }
    
    mutating func revealAllCards() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = true
        }
    }
    
    mutating func restart() {
        cards.shuffle()
        
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
            cards[cardIndex].isFaceUp = false
        }
        
        moveCount = 0
    }
    
    struct Card: Equatable {
        static func ==(lhs: Card, rhs: Card) -> Bool { lhs.id == rhs.id }
        
        let id: Int
        let content: String
        var isFaceUp = false
        var isMatched = false
        
        init(id: Int, content: String) {
            self.id = id
            self.content = content
        }
    }
    
    static let example = MemoryGame(difficulty: GameDifficulty.example, contents: Theme.example.contents)
}
