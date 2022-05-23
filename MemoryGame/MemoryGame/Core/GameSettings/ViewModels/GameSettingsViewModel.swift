//
//  GameSettingsViewModel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 6/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

class GameSettingsViewModel: ObservableObject {
    @Published var selectedDifficulty: GameDifficulty = .easy
    @Published var selectedTheme = themes.first!
    @Published var isUserReady = false
    
    // A theme is available when it has as many cards (or more) as the difficulty requires.
    var availableThemes: [Theme] {
        Self.themes.filter { $0.contents.count >= selectedDifficulty.numberOfPairsOfCards }
    }
    
    func createGame() -> MemoryGame {
        let contents = selectedTheme.contents
        let game = MemoryGame(difficulty: selectedDifficulty, contents: contents)
        return game
    }
    
    func select(_ theme: Theme) {
        self.selectedTheme = theme
    }
    
    func randomThemeIcon(_ theme: Theme) -> String {
        theme.contents.randomElement()!
    }
    
    func select(_ difficulty: GameDifficulty) {
        self.selectedDifficulty = difficulty
    }
}

extension GameSettingsViewModel {
    static let themes = [
        Theme(title: "Vehicles", color: .gradient,
              contents: ["🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚲", "⛵️", "🛸", "🛶", "🛺", "🚌", "🏍", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚈"]),
        Theme(title: "Animals", color: .gradient,
              contents: ["🐶", "🐱", "🐭", "🐰", "🐹", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🦋", "🐌", "🪰", "🐞", "🐙", "🐬", "🐳"]),
        Theme(title: "Plants", color: .gradient,
              contents: ["🌹", "🌺", "🍀", "💐", "🌸", "🌷", "🌲", "🌻", "☘️", "🌱", "🥀", "🌵", "🍄", "🍁", "🪴", "🌼"]),
    ]
}
