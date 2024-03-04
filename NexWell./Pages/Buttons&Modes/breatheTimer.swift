//
//  breatheTimer.swift
//  NexWell.
//
//  Created by Keoni Li on 10/16/23.
//

import SwiftUI

//scroll to determine how long for
struct breatheTimer: View {
    let bgColor: Color
    let color1: Color
    let color2: Color
    let color3: Color
    var light : Bool
    
    @State private var switchy = false
 
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
                    
            Text("Breath Timer")
                .foregroundStyle(light ? .black : .white)
                .font(.system(size: 25, weight: .heavy))
                .offset(y: -UIScreen.main.bounds.height * 0.05 - 180)
            
            breathThingy(color1: color1, color2: color3, ringColor: color2, digitColor: .white, secondsRemaining: 4, totalSeconds: 4, shadow: .black, bgColor: bgColor, showingTime: true, rounds: 5, switchy: switchy, breath: 4)
            
        }
        
    }
}

#Preview {
    breatheTimer(bgColor: .gray, color1: .blue, color2: .cyan, color3: .green, light: false)
}
