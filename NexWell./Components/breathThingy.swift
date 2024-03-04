//
//  breathThingy.swift
//  NexWell.
//
//  Created by Keoni Li on 8/14/23.
//

import SwiftUI

//Make circle more smooth. Different graphics. Remove start button when pushed.
//Reset the timer

struct breathThingy: View {
    let color1 : Color
    let color2 : Color
    let ringColor : Color
    let digitColor : Color
    @State var secondsRemaining : Int
    @State var totalSeconds : Int
    let shadow : Color
    let bgColor : Color
    //Maybe do something with this
    let showingTime : Bool
    
    @State var rounds : Int
    @State var otherRounds = 0
    @State var switchy : Bool
    @State var breath : Int
    @State private var finished = false
    
    var Green = Color(red: 56/255, green: 1, blue: 212/255)
    
    @State private var isActive: Bool = false
    @State private var timer: Timer? = nil

    enum TimerState {
        case active, rest
    }
    @State var timerState: TimerState = .active
    
    var body: some View {
        VStack {
            ZStack {
                // Your circular progress view goes here, use UIKit to customize
                LinearGradient(colors: [color1, color2], startPoint: .top, endPoint: .trailing)
                    .frame(width: UIScreen.main.bounds.width/1.4, height: UIScreen.main.bounds.height/1.4)
                    .clipShape(Circle())
                    .shadow(color: shadow, radius: 2.5)
                
                if !finished {
                    CircularProgress(progress: CGFloat(secondsRemaining) / CGFloat(breath),innerCircleColor: showingTime ? UIColor(Color.white.opacity(0.25)) : UIColor.clear)
                        .frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/1.3)
                }
                
                Circle()
                    .frame(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/1.25)
                    .opacity(0)
                    .overlay {
                        Circle()
                            .stroke(ringColor, lineWidth: 5)
                    }
                
                if !finished {
                    Text(showingTime ? timeString(time: TimeInterval(secondsRemaining)) : "")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(digitColor)
                        .padding()
                }
                
                if finished {
                    Text("↓")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(digitColor)
                        .padding()
                }
                
                if showingTime && !finished {
                    Text(switchy ? "Out" : "In")
                        .foregroundColor(switchy ? .red : Green)
                        .rotationEffect(.degrees(switchy ? 180 : 0))
                        .font(.system(size: 20))
                        .offset(y: switchy ? UIScreen.main.bounds.height * 0.12 : UIScreen.main.bounds.height * -0.12)
                }
                
            }.animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 2), value: switchy)
            
            if !isActive {
                Button(action: {
                    isActive = true
                    
                    //Change timer interval to 0.1
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        if secondsRemaining > 0 {
                            secondsRemaining -= 1
                            
                            
                        } else if rounds > 0 {
                            switch timerState {
                            case .active:
                                switchy = true
                                // End of active time, begin rest time
                                rounds -= 1
                                otherRounds += 1
                                secondsRemaining = breath
                                timerState = .rest
                            case .rest:
                                switchy = false
                                // End of rest time, begin next round
                                secondsRemaining = breath
                                timerState = .active
                            }
                            
                        } else {
                            timer?.invalidate()
                            timer = nil
                            finished.toggle()
                        }
                    }
                }) {
                    if rounds == 5 && totalSeconds == secondsRemaining {
                        regRR(widthDiv: 4, heightDiv: 18, color: .cyan, text: "Go 40(s)", tColor: .white)
                    }
                    else {
                        regRR(widthDiv: 4, heightDiv: 18, color: .cyan, text: "Resume", tColor: .white)
                    }
                    
                }
                .offset(y: UIScreen.main.bounds.height * -0.2 + 10)
                
            .disabled(isActive)
            }
            
            else {
                if !finished {
                    Button(action: {
                        isActive = false
                        timer?.invalidate()
                    }) {
                        regRR(widthDiv: 5, heightDiv: 18, color: .pink, text: "Pause", tColor: .white)
                    }
                    .offset(y: UIScreen.main.bounds.height * -0.2 + 10)
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    // Convert the time to a string in format mm:ss
    func timeString(time:TimeInterval) -> String {
        let seconds = (Int(time) % 60)
        return String(format:"%02i", seconds)
    }
}

struct CircularProgress: UIViewRepresentable {
    var progress: CGFloat
    var innerCircleColor: UIColor
    
    func makeUIView(context: Context) -> CircularProgressView {
        let progressView = CircularProgressView()
        
        return progressView
    }

    func updateUIView(_ uiView: CircularProgressView, context: Context) {
        uiView.progress = progress
        uiView.innerCircleColor = innerCircleColor
    }
}




struct breathThingy_Previews: PreviewProvider {
    static var previews: some View {
        breathThingy(color1: .purple, color2: .black, ringColor: .white, digitColor: .white, secondsRemaining: 4, totalSeconds: 4, shadow: .black, bgColor: .gray, showingTime: true, rounds: 1 , switchy: false, breath: 4)
    }
}
