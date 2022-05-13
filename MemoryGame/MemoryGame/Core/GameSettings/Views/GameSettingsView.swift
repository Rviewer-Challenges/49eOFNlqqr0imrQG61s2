//
//  ContentView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//

import SwiftUI

struct GameSettingsView: View {
    @ObservedObject var settings = GameSettingsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Constants.kBackgroundColor)
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Difficulty Section
                            Section { difficultySelection }
                            header: {
                                Text("DIFFICULTY")
                                    .bold()
                            }
                            
                            Spacer(minLength: 10)
                            
                            // Theme Section
                            Section { themeSelection }
                            header: {
                                Text("THEME")
                                    .bold()
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    
                    startGameButton
                        .padding()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Game Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE 3"))
            .preferredColorScheme(.dark)
        
        GameSettingsView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

extension GameSettingsView {
    
    // MARK: - Difficulty Picker -
    var difficultySelection: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
            ForEach(GameDifficulty.allCases, id: \.self) { difficulty in
                SelectionButton(
                    icon: difficulty.icon,
                    title: difficulty.title,
                    isSelected: difficulty == settings.selectedDifficulty) {
                        settings.select(difficulty)
                    }
                .padding(.horizontal, 5)
            }
        }
    }
    
    // MARK: - Theme Picker -
    var themeSelection: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
            ForEach(settings.availableThemes, id: \.self) { theme in
                SelectionButton(
                    icon: theme.contents.first!,
                    title: theme.title,
                    isSelected: theme == settings.selectedTheme) {
                        settings.select(theme)
                    }
                .padding(.horizontal, 5)
            }
        }
    }
    
    // MARK: - Start Game Button -
    var startGameButton: some View {
        NavigationLink {
            let game = settings.createGame()
            MemoryGameView(game: game, theme: settings.selectedTheme)
        } label: {
            MainButtonLabel(title: "Start game!")
                .frame(height: 50)
        }
    }
}
