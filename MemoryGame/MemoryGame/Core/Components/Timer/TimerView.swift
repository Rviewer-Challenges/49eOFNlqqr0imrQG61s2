//
//  TimerView.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 6/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: GameTimer
    let id: String
    
    init(id: String, minutes: Int, seconds: Int) {
        self.id = id
        self.timer = GameTimer(minutes: minutes, seconds: seconds)
        timer.start()
    }
    
    var body: some View {
        if timer.timeIsUp {
            Text("TIME IS UP!")
                .foregroundColor(.red)
                .bold()
        } else {
            Text("\(timer.minutes) : \(String(format: "%02d", timer.seconds))")
                .foregroundColor(timer.timeIsCritical(underMinutes: 0, seconds: 10) ? .red : .green)
                .bold()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(id: "Test", minutes: 1, seconds: 0)
    }
}

extension TimerView: Equatable {
    static var id = 0
    
    static func ==(lhs: TimerView, rhs: TimerView) -> Bool {
        lhs.id == rhs.id
    }
}
