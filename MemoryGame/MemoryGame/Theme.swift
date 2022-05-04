//
//  Theme.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

enum Theme: CaseIterable {
    case pokemon, emojis
    
    var title: String {
        switch self {
        case .pokemon: return "Pokémon"
        case .emojis: return "Emojis"
        }
    }
    
    static let example = Theme.pokemon
}
