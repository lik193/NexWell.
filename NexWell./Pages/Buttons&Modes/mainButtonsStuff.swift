//
//  mainButtonsStuff.swift
//  NexWell.
//
//  Created by Keoni Li on 10/16/23.
//

import SwiftUI

struct mainButtonsStuff: View {
    @Binding var color1: Color
    @Binding var color2: Color
    @Binding var color3: Color
    @Binding var light: Bool
    
    let trueGrey : Color
    
    @State private var mode1 = false
    @State private var mode2 = false
    @State private var mode3 = false
    
    @StateObject var timerManager = TimerManager()
    
    var body: some View {
        ZStack {
            HStack {
                let r = UIScreen.main.bounds.width / 3.5
                let r2 = r - 20
                
                Button {
                    mode1.toggle()
                } label: {
                    buttonCirc(color: color1, r1: r, r2: r2, text: "wind.circle", textColor: .white, size: 50)
                }
                .sheet(isPresented: $mode1) {
                    breatheTimer(bgColor: trueGrey, color1: color1, color2: color2, color3: color3, light: light)
                        .presentationDetents([.fraction(0.75)])
                }
                
                Button {
                    mode3.toggle()
                } label: {
                    buttonCirc(color: color3, r1: r, r2: r2, text: "paintpalette.fill", textColor: .white, size: 50)
                }
                .sheet(isPresented: $mode3) {
                    colorSettings(color1: $color1, color2: $color2, color3: $color3, light: $light, trueGrey: trueGrey)
                        .presentationDetents([.fraction(0.75)])
                }
                
                Button {
                    mode2.toggle()
                } label: {
                    buttonCirc(color: color2, r1: r, r2: r2, text: "timer", textColor: .white, size: 50)
                }
                .sheet(isPresented: $mode2) {
                    Promodoro(timerManager: timerManager, light: light, bgColor: trueGrey, color1: color1, color2: color2, color3: color3)
                        .presentationDetents([.fraction(0.75)])
                }
                
            }
            .offset(y: UIScreen.main.bounds.height * 0.02 + 30)
            
            
        }
        
        
    }
}



#Preview {
    mainButtonsStuff(color1: .constant(.blue), color2: .constant(.cyan), color3: .constant(.green), light: .constant(false), trueGrey: Color(red: 0.1725, green: 0.188, blue: 0.188))
}
