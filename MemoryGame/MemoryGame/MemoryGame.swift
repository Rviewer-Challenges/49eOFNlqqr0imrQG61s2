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
    private(set) var moveCounter: Int
    private(set) var remainingPairsCounter: Int
    
    struct Card {
        private let id: String
        let content: String
    }
}
