//
//  stuff.swift
//  NexWell.
//
//  Created by Keoni Li on 8/12/23.
//

import SwiftUI

struct stuff: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct perimeterRR: View {
    let widthDiv : CGFloat
    let heightDiv : CGFloat
    let innerColor : Color
    let color2 : Color
    let offY : CGFloat
    let offX : CGFloat
    
    var body: some View {
        LinearGradient(colors: [innerColor, color2], startPoint: .top, endPoint: .bottomTrailing)
            .frame(width: UIScreen.main.bounds.width/widthDiv, height: UIScreen.main.bounds.height/heightDiv)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .opacity(0.75)
            .offset(x: UIScreen.main.bounds.width * offX, y: UIScreen.main.bounds.width * offY)
    }
}

struct regRR: View {
    let widthDiv : CGFloat
    let heightDiv : CGFloat
    let color : Color
    let text : String
    let tColor : Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: UIScreen.main.bounds.width/widthDiv, height: UIScreen.main.bounds.height/heightDiv)
            .foregroundColor(color)
            Text(text)
                .foregroundColor(tColor)
        }
        
    }
}

struct buttonCirc: View {
    let color : Color
    let r1 : CGFloat
    let r2 : CGFloat
    let text : String
    let textColor : Color
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: r1)
                .foregroundColor(color)
            Circle()
                .frame(width: r2)
                .foregroundColor(.white)
                .opacity(0.25)
            Image(systemName: text)
                .foregroundColor(textColor)
                .font(.system(size: size))
        }
    }
}

struct buttonCirc2: View {
    let color : Color
    let r1 : CGFloat
    let r2 : CGFloat
    let text : String
    let textColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: r1)
                .foregroundColor(color)
            Circle()
                .frame(width: r2)
                .foregroundColor(.white)
                .opacity(0.25)
            Image(systemName: text)
                .foregroundColor(textColor)
        }
    }
}

struct listThing: View {
    let title: String
    let color: Color
    let color2: Color
    let widthDiv: CGFloat
    let heightDiv: CGFloat
    
    var rect: some View {
        RoundedRectangle(cornerRadius: 35)
            .foregroundColor(color)
            .frame(width: UIScreen.main.bounds.width/widthDiv, height: UIScreen.main.bounds.height/heightDiv)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [color, color2], startPoint: .leading, endPoint: .bottomTrailing)
                .frame(width: UIScreen.main.bounds.width/widthDiv, height: UIScreen.main.bounds.height/heightDiv)
                .mask(rect)
            
            RoundedRectangle(cornerRadius: 35)
                .foregroundColor(.white)
                .opacity(0.3)
                .frame(width: UIScreen.main.bounds.width/(widthDiv*1.1), height: UIScreen.main.bounds.height/(heightDiv*1.3))
                
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .heavy))
                .frame(width: UIScreen.main.bounds.width/(widthDiv*1.3))
        }
        
    }
    
}

struct barOnTheBottom: View {
    let dadsMilk = Color.black
    
    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.main.bounds.width/1, height: UIScreen.main.bounds.height/12.5)
            .foregroundColor(dadsMilk)
    }
}



struct stuff_Previews: PreviewProvider {
    static var previews: some View {
        barOnTheBottom()
    }
}
