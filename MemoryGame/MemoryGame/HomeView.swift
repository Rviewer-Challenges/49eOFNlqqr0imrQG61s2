//
//  ContentView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 3/5/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("")
                .navigationTitle("Memory Game!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE 3"))
        
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
