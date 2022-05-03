//
//  GameView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct GameView: View {
    private let theme: Theme
    
    @State private var remainingTime = 1
    
    init(theme: Theme) {
        self.theme = theme
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button("Volver al inicio", action: goBackToMenu)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
            }
            .padding()
            .navigationTitle(theme.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func goBackToMenu() {
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(theme: .pokemon)
    }
}
