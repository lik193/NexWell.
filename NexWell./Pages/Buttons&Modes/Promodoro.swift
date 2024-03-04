//
//  Promodoro.swift
//  NexWell.
//
//  Created by Keoni Li on 10/16/23.
//

import SwiftUI

struct Promodoro: View {
    @ObservedObject var timerManager: TimerManager
        
    var hours: Int { timerManager.currentTime / 3600 }
    var minutes: Int { (timerManager.currentTime % 3600) / 60 }
    var seconds: Int { (timerManager.currentTime % 3600) % 60 }
    
    var light: Bool
    let bgColor: Color
    let color1: Color
    let color2: Color
    let color3: Color
    var timeColor: Color { timerManager.workMode ? .green : .red }
        
    @State private var showSetting = true
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            Text("Pomodoro Timer")
                .foregroundStyle(light ? .black : .white)
                .font(.system(size: 25, weight: .heavy))
                .offset(y: -UIScreen.main.bounds.height * 0.05 - 180)
            
            LinearGradient(colors: [color1,color2,color3], startPoint: .leading, endPoint: .bottomTrailing)
                .frame(width: 335, height: 375)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 325, height: 365)
                .foregroundStyle(.black)
                .opacity(0.5)
            
            
            
            VStack {
                if showSetting {
                    HStack {
                        VStack {
                            Text("Work Time:")
                                .font(.system(size: 20, weight: .bold))
                            Picker("Work Duration", selection: $timerManager.workMinutes) {
                                ForEach(1...60, id: \.self) {
                                    Text("\($0) minutes")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: UIScreen.main.bounds.width/3)
                        }
                        .foregroundStyle(.white)
                            
                        VStack {
                            Text("Break Time:")
                                .font(.system(size: 20, weight: .bold))
                            Picker("Rest Duration", selection: $timerManager.restMinutes) {
                                ForEach(1...60, id: \.self) {
                                    Text("\($0) minutes")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: UIScreen.main.bounds.width/3)
                        }
                        .foregroundStyle(.white)
                        
                    }
                    .frame(height: UIScreen.main.bounds.width/3)
                    .offset(y:15)
                }
                
                    
                    
                Text(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(timeColor)
                    
                HStack {
                    Button {
                        timerManager.startTimer()
                        showSetting = false
                    } label: {
                        buttonCirc2(color: .green, r1: 55, r2: 45, text: "play.fill", textColor: .black)
                    }
                    
                    Button(action: timerManager.stopTimer) {
                        buttonCirc2(color: .pink, r1: 55, r2: 45, text: "pause.fill", textColor: .black)
                    }
                    
                    Button {
                        timerManager.resetTimer()
                        showSetting = true
                    } label: {
                        buttonCirc2(color: .white, r1: 50, r2: 45, text: "arrow.clockwise.circle.fill", textColor: .black)
                    }
                }
                .offset(y: -15)
            }
            
            Text("Timer runs until stopped.")
                .frame(width: 270)
                .foregroundStyle(light ? .black : .white)
                .offset(y:210)
        }
        
    }
        
}


#Preview {
    Promodoro(timerManager: TimerManager(), light: false, bgColor: .gray, color1: .blue, color2: .cyan, color3: .green)
}
