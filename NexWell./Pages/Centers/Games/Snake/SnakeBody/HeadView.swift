//
//  HeadView.swift
//  Snake
//
//  Created by Denis Horvat  on 30.08.2023.
//

import SwiftUI

struct HeadView: View {
    
    var size: CGFloat
    var direction: Direction
    var position: CGPoint
    let snColor = Color(red: 74/250, green: 250/255, blue: 30/255)
    
    var body: some View {
        ZStack{
            if direction == .right{
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .position(position)
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size/2, height: size)
                    .position(CGPoint(x:position.x-size/4, y:position.y))
                
            }
            else if direction == .left{
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .position(position)
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size/2, height: size)
                    .position(CGPoint(x:position.x+size/4, y:position.y))
                
            }
            else if direction == .up{
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .position(position)
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size/2)
                    .position(CGPoint(x:position.x, y:position.y+size/4))
                
            }
            else if direction == .down{
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .position(position)
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size/2)
                    .position(CGPoint(x:position.x, y:position.y-size/4))
                
            }
            else {
                Rectangle()
                    .foregroundColor(snColor)
                    .frame(width: size, height: size)
                    .position(position)
            }
        }
    }
}

struct HeadView_Previews: PreviewProvider {
    static var previews: some View {
        HeadView(size: 10, direction: .down, position: CGPoint(x:10,y:10))
    }
}
