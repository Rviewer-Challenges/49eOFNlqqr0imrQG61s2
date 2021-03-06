//
//  GameSettingsViewModel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 6/5/22.
//  Copyright ÂĐ 2022 Francisco Javier Gallego Lahera. All rights reserved.
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
              contents: ["ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "ð", "âïļ", "ðē", "âĩïļ", "ðļ", "ðķ", "ðš", "ð", "ð", "ðĄ", "ðĩ", "ð", "ð", "ð", "ðŧ", "ð"]),
        Theme(title: "Animals", color: .gradient,
              contents: ["ðķ", "ðą", "ð­", "ð°", "ðđ", "ðĶ", "ðŧ", "ðž", "ðŧââïļ", "ðĻ", "ðŊ", "ðĶ", "ðŪ", "ð·", "ðļ", "ðĩ", "ð", "ðĶ", "ð", "ðŠ°", "ð", "ð", "ðŽ", "ðģ"]),
        Theme(title: "Plants", color: .gradient,
              contents: ["ðđ", "ðš", "ð", "ð", "ðļ", "ð·", "ðē", "ðŧ", "âïļ", "ðą", "ðĨ", "ðĩ", "ð", "ð", "ðŠī", "ðž"]),
    ]
}
