//
//  TimerView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 8/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    let minutes: Int
    let seconds: Int
    let timeIsCritical: Bool
    
    var body: some View {
        Text("\(minutes) \(seconds.isMultiple(of: 2) ? ":" : " ") \(String(format: "%02d", seconds))")
            .bold()
            .padding()
            .padding(.horizontal, 5)
            .foregroundColor(.white)
            .background(timeIsCritical ? .red : .green)
            .frame(height: 32)
            .clipShape(Capsule())
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(minutes: 1, seconds: 0, timeIsCritical: true)
    }
}
