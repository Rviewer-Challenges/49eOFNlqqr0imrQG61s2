//
//  GameDifficulty.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

enum GameDifficulty: CaseIterable {
    case easy, medium, hard
    
    var title: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    var numberOfRows: Int {
        switch self {
        case .easy: return 4
        case .medium: return 6
        case .hard: return 6
        }
    }
    
    var numberOfColumns: Int {
        switch self {
        case .easy: return 4
        case .medium: return 4
        case .hard: return 5
        }
    }
    
    var numberOfPairsOfCards: Int { (numberOfColumns * numberOfRows) / 2}
    
    static let example = GameDifficulty.medium
}
