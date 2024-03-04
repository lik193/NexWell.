//
//  moreStuff.swift
//  NexWell.
//
//  Created by Keoni Li on 9/20/23.
//

import SwiftUI

struct moreStuff: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct topBanner: View {
    let c1: Color
    let c2: Color
    let c3: Color
    let heightDiv: CGFloat
    let padding: CGFloat
    let image: String
    
    var mask: some View {
        RoundedRectangle(cornerRadius: 15)
            
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [c1, c2, c3], startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask(mask)
                .frame(height: UIScreen.main.bounds.height/(heightDiv))
            Image(systemName: image)
                .font(.system(size: 75))
                .offset(x: 100, y: UIScreen.main.bounds.height * 0.04 + 25)
                .foregroundStyle(.white)
                .opacity(0.25)
            
        }
        .offset(y: padding)
    }
}

struct invisBox: View {
    let height: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 1)
            .frame(width: 100, height: height)
            .opacity(0)
    }
}

struct moreStuff_Previews: PreviewProvider {
    static var previews: some View {
        topBanner(c1: Color.red, c2: Color.blue, c3: Color.green, heightDiv: 3, padding: -200, image: "house.circle")
    }
}
