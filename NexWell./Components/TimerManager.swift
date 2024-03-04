//
//  TimerManager.swift
//  NexWell.
//
//  Created by Keoni Li on 10/16/23.
//

import SwiftUI

class TimerManager: ObservableObject {
    @Published var timer: Timer? = nil
    @Published var currentTime = 0
    @Published var workMode = true
    var workMinutes = 25
    var restMinutes = 5
    
    func startTimer() {
        timer?.invalidate()  // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime += 1
            if self.workMode && self.currentTime >= self.workMinutes * 60 {
                self.workMode.toggle()
                self.currentTime = 0
            } else if !self.workMode && self.currentTime >= self.restMinutes * 60 {
                self.workMode.toggle()
                self.currentTime = 0
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func resetTimer() {
        timer?.invalidate()
        currentTime = 0
        workMode = true
    }
}
