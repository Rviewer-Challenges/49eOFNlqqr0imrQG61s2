//
//  Theme.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 5/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

struct Theme: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
    let color: ThemeColor
    let contents: [String]
    
    init(title: String, color: ThemeColor, contents: [String]) {
        self.title = title
        self.color = color
        self.contents = Array(Set(contents))
    }
    
    enum ThemeColor {
        case purple, red, orange, yellow, green, blue
    }
    
    static let example = Theme(title: "Vehicles", color: .blue,
                               contents: ["🚂", "🚀", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒", "✈️", "🚲", "⛵️", "🛸", "🛶", "🛺", "🚌", "🏍", "🚡", "🛵", "🚗", "🚚", "🚇", "🛻", "🚈"])
}
