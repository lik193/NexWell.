//
//  ButtonsView.swift
//  Snake
//
//  Created by Denis Horvat  on 28.08.2023.
//

import SwiftUI

struct ButtonsView: View {
    
    @Binding var direction: Direction
    
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .frame(width: 80, height: 30)
                    .opacity(0)
                HStack {
                    ButtonView(imageName: "arrow.up")
                        .onTapGesture {
                            if direction != .down {
                                direction = .up
                            }
                        }
                }
                HStack {
                    ButtonView(imageName: "arrow.left")
                        .onTapGesture {
                            if direction != .right {
                                direction = .left
                            }
                        }
                    ButtonView(imageName: "arrow.down")
                        .onTapGesture {
                            if direction != .up {
                                direction = .down
                            }
                        }
                    ButtonView(imageName: "arrow.right")
                        .onTapGesture {
                            if direction != .left {
                                direction = .right
                            }
                        }
                }
            }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView(direction: .constant(.right))
    }
}
