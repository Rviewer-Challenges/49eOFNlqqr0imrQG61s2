//
//  MemoryGameViewModel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 4/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

class MemoryGameViewModel: ObservableObject {
    @Published private var memoryGame: MemoryGame
    private let theme: Theme
    
    var cards: [MemoryGame.Card] {  memoryGame.cards }
    
    var moveCount: Int { memoryGame.moveCount }
    var remainingPairsCount: Int { memoryGame.remainingPairsCount }
    
    var gameDifficulty: GameDifficulty { memoryGame.difficulty }
    var title: String { theme.title }
    var cardColor: Gradient {
        getColor(for: theme.color)
    }
    
    // Alert
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var alertOKAction = { }
    @Published var showingAlert = false
    
    init(memoryGame: MemoryGame, theme: Theme) {
        self.memoryGame = memoryGame
        self.theme = theme
    }
    
    func select(_ card: MemoryGame.Card) {
        memoryGame.select(card)
    }
    
    func endTimeHandler() {
        revealAllCards()
    }
    func revealAllCards() {
        withAnimation { memoryGame.revealAllCards() }
    }
    
    func restart() {
        memoryGame.restart()
    }
    
    // Alert
    
    func giveUp(withConsequence consequence: @escaping () -> Void) {
        alertTitle = "Give up"
        alertMessage = "Do you really want to give up?"
        alertOKAction = consequence
        showingAlert = true
    }
    
    // Helper methods
    func getColor(for theme: Theme.ThemeColor) -> Gradient {
        switch theme {
        case .purple: return Gradient(colors: [.purple])
        case .red: return Gradient(colors: [.red])
        case .orange: return Gradient(colors: [.orange])
        case .yellow: return Gradient(colors: [.yellow])
        case .green: return Gradient(colors: [.green])
        case .blue: return Gradient(colors: [.blue])
        case .gradient: return Gradient(colors: [Color(Constants.kMainColor), .pink])
        }
    }
}
