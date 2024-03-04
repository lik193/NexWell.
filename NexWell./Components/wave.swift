//
//  wave.swift
//  NexWell.
//
//  Created by Keoni Li on 8/12/23.
//
import SwiftUI

struct wave: View {
    // Animation control
    var isAnimating : Bool
    var color : Color
    
    // Number of rectangles
    let rects = 20

    // Amplitude and frequency of wave
    let amplitude: Double = 20
    let frequency: Double = 0.25

    // Time offset for each rectangle to create wave effect
    let offsetStep: Double = 0.25

    // Timer to update animation
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    @State private var time: Double = 0

    var body: some View {
        VStack {
            GeometryReader { geo in
                HStack(spacing: 0) {
                    ForEach(0..<rects, id: \.self) { i in
                        Rectangle()
                            .fill(color)
                            .frame(
                                width: geo.size.width / CGFloat(rects),
                                height: max(CGFloat(amplitude + amplitude * sin(2 * .pi * frequency * (time - offsetStep * Double(i)))) , 5)
                            )
                            .cornerRadius(10)
                            

                    }
                }
            }
        }
        .onReceive(timer) { _ in
            if isAnimating {
                self.time += 0.02
            }
        }
        
    }
}

struct wave_Previews: PreviewProvider {
    static var previews: some View {
        wave(isAnimating: true, color: Color.blue)
    }
}
