//
//  MemoryGameView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var game: MemoryGameViewModel
    private let theme: Theme
    
    @Environment(\.dismiss) var dismiss
    @State private var remainingTime = 1
    
    init() {
        self._game = ObservedObject(initialValue: MemoryGameViewModel())
        self.theme = .example
    }
    
    var body: some View {
        VStack {
            Text("Remaining pairs: \(game.remainingPairsCount)")
            
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                    ForEach(game.cards, id: \.id) { card in
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 10)
                            
                            if card.isFaceUp {
                                shape.fill(.white)
                                shape.strokeBorder(lineWidth: 3)
                                    .foregroundColor(.blue)
                                Text(String(card.content))
                            } else {
                                shape.fill(.blue)
                            }
                        }
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.select(card)
                        }
                    }
                }
            }

            backButton
        }
        .padding()
        .navigationTitle(theme.title)
    }
    
    func goBackToMenu() {
        dismiss()
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}

extension MemoryGameView {
    
    // MARK: - Back Button -
    var backButton: some View {
        Button("Go back", action: goBackToMenu)
            .padding()
    }
}
