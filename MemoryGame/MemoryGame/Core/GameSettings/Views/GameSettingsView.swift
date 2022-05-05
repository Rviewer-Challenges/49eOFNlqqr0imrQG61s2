//
//  ContentView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//

import SwiftUI

struct GameSettingsView: View {
    @State private var gameDifficulty: GameDifficulty = .easy
    @State private var theme = Self.themes.first!
    @State private var isUserReady = false
    
    var body: some View {
        NavigationView {
            Form {
                // Difficulty Section
                Section {
                    difficultySelection
                } header: {
                    Text("Difficulty")
                }
                
                // Theme Section
                Section {
                    themeSelection
                } header: {
                    Text("Theme")
                }
                
                // Start Game Section
                Section {
                    startGameButton
                }
            }
            .navigationTitle("Game Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE 3"))
        
        GameSettingsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

extension GameSettingsView {
    
    // MARK: - Difficulty Picker -
    var difficultySelection: some View {
        Picker("Game difficulty", selection: $gameDifficulty) {
            ForEach(GameDifficulty.allCases, id: \.self) {
                Text($0.title)
            }
        }
        .pickerStyle(.segmented)
    }
    
    // MARK: - Theme Picker -
    var themeSelection: some View {
        HStack {
            Text("Select a theme")
            
            Spacer()
            
            Picker("Select a theme", selection: $theme) {
                ForEach(Self.themes) { theme in
                    Text(theme.title).tag(theme)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    // MARK: - Start Game Button -
    var startGameButton: some View {
        NavigationLink {
            let game = createGame()
            MemoryGameView(game: game!, theme: theme)
        } label: {
            Text("Start game!")
        }
    }
    
    func createGame() -> MemoryGame? {
        let contents = theme.contents
        let game = MemoryGame(difficulty: gameDifficulty, contents: contents)
        return game
    }
}

// This will be an extension of view's viewmodel
extension GameSettingsView {
    static let themes = [
        Theme(title: "Vehicles", color: .blue,
              contents: ["🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚲", "⛵️", "🛸", "🛶", "🛺", "🚌", "🏍", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚈"]),
        Theme(title: "Animals", color: .blue,
              contents: ["🐶", "🐱", "🐭", "🐰", "🐹", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🦋", "🐌", "🪰", "🐞", "🐙", "🐬", "🐳"]),
        Theme(title: "Plants", color: .blue,
              contents: ["🌹", "🌺", "🍀", "💐", "🌸", "🌷", "🌲", "🌻", "☘️", "🌱", "🥀", "🌵", "🍄", "🍁", "🪴", "🌼"]),
    ]
}
