//
//  MainButtonLabel.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 10/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct MainButtonLabel: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color(Constants.kMainColor)
            Text(title)
                .padding(5)
                .padding(.horizontal, 10)
                .foregroundColor(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct MainButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonLabel(title: "Main Button")
            .frame(height: 50)
            .padding(.horizontal)
    }
}
