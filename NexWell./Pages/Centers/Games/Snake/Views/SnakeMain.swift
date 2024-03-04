//
//  MainView.swift
//  Snake
//
//  Created by Denis Horvat  on 26.08.2023.
//

import SwiftUI

struct SnakeMainView: View {
    
    @StateObject var snake = Snake()  // This initializes a new Snake object
        
    @Environment(\.dismiss) private var dismiss

    init(selectedSnakeSpeed: Int, selectedSnakeSize: Double) {
            
            // Initialize the snake's speed and size using the provided values
            _snake = StateObject(wrappedValue: Snake())
            
    }
    
    var bgColor = Color.gray
    
    var body: some View {
        
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack{
                    ScoreView(score: snake.snakePositions.count-3, topScore: snake.topScore)
                        .offset(y: UIScreen.main.bounds.height * 0.025)
                    
                    GeometryReader{ geometry in
                        ZStack(alignment: .center){
                            
        
                            //playground
                            Rectangle()
                                .foregroundColor(bgColor)
                                .shadow(radius: 6)
                            
                            //Snake body
                            HeadView(size: snake.snakeSize, direction: snake.direction, position: snake.snakePositions[0])
                            
                            ForEach(1..<snake.snakePositions.count, id:\.self) { index in
                                BodyView(size: snake.snakeSize, position: snake.snakePositions[index])

                            }
                            //Food
                            RoundedRectangle(cornerRadius: 3)
                                .foregroundColor(.red)
                                .frame(width: snake.snakeSize, height:snake.snakeSize)
                                .position(snake.foodPosition)
                            
                        }
                        .onReceive(snake.timer){ _ in
                            snake.move(in: geometry)
                        }
                        .border(.gray, width: 2)
                    }
                    
                    Spacer()
                    
                    ButtonsView(direction: $snake.direction)
                        .offset(y: -UIScreen.main.bounds.height * 0.03)
                }
                .background(.black)
                .navigationBarHidden(true)
                .frame(height: UIScreen.main.bounds.height/1.1)
                
                Button(action: { dismiss() } ) {
                    ZStack {
                        regRR(widthDiv: 8, heightDiv: 20, color: .pink, text: "Exit", tColor: .white)
                    }
                    
                        
                }
                .navigationBarBackButtonHidden(true)
                .offset(x: -UIScreen.main.bounds.width / 3 + 35, y: UIScreen.main.bounds.height/3 - 55)
            }
            .offset(y: UIScreen.main.bounds.height * 0.05)
            
        
        
        
    }
}

struct SnakeMainView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeMainView(selectedSnakeSpeed: 5, selectedSnakeSize: 5)
    }
}
