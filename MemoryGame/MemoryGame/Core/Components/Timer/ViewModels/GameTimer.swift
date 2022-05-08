//
//  GameTimer.swift
//  MemoryGame
//
//  Created by Francisco Javier Gallego Lahera on 6/5/22.
//  Copyright © 2022 Francisco Javier Gallego Lahera. All rights reserved.
//

import Foundation

class GameTimer: ObservableObject {
    @Published private(set) var minutes: Int
    @Published private(set) var seconds: Int
    @Published private(set) var isPaused = false
    var timeIsUp: Bool { minutes == 0 && seconds == 0 }
    private(set) var timer: Timer?
    var endTimeHandler: () -> Void
    
    init(minutes: Int, seconds: Int, endTimeHandler: @escaping () -> Void) {
        self.minutes = (minutes >= 0) ? minutes : 1
        self.seconds = (seconds > 0) ? seconds : 0
        self.endTimeHandler = endTimeHandler
    }
    
    func start() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                
                if self.isPaused == false {
                    if self.seconds > 0 {
                        self.seconds -= 1
                        
                        if self.seconds == 0 && self.minutes == 0 {
                            self.endTimeHandler()
                            timer.invalidate()
                        }
                    } else if self.minutes > 0 {
                        self.seconds = 59
                        self.minutes -= 1
                    }
                }
            }
        }
    }
    
    func pauseOrResume() {
        isPaused.toggle()
    }
    
    func reset(toMinutes minutes: Int, seconds: Int) {
        timer?.invalidate()
        timer = nil
        
        self.minutes = minutes
        self.seconds = seconds
        start()
    }
    
    func timeIsCritical(underMinutes minutes: Int, seconds: Int) -> Bool {
        self.minutes <= minutes && self.seconds <= seconds
    }
}
