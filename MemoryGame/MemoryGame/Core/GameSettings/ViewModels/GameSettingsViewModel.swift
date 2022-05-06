//
//  GameSettingsViewModel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 6/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

class GameSettingsViewModel: ObservableObject {
    @Published var gameDifficulty: GameDifficulty = .easy
    @Published var theme = themes.first!
    @Published var isUserReady = false
    
    // A theme is available when it has as many cards (or more) as the difficulty requires.
    var availableThemes: [Theme] {
        Self.themes.filter { $0.contents.count >= gameDifficulty.numberOfPairsOfCards }
    }
    
    func createGame() -> MemoryGame {
        let contents = theme.contents
        let game = MemoryGame(difficulty: gameDifficulty, contents: contents)
        return game
    }
}

extension GameSettingsViewModel {
    static let themes = [
        Theme(title: "Vehicles", color: .blue,
              contents: ["🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚲", "⛵️", "🛸", "🛶", "🛺", "🚌", "🏍", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚈"]),
        Theme(title: "Animals", color: .blue,
              contents: ["🐶", "🐱", "🐭", "🐰", "🐹", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🦋", "🐌", "🪰", "🐞", "🐙", "🐬", "🐳"]),
        Theme(title: "Plants", color: .blue,
              contents: ["🌹", "🌺", "🍀", "💐", "🌸", "🌷", "🌲", "🌻", "☘️", "🌱", "🥀", "🌵", "🍄", "🍁", "🪴", "🌼"]),
    ]
}
