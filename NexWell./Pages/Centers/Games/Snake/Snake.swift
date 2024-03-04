//
//  Snake.swift
//  Snake
//
//  Created by Denis Horvat  on 28.08.2023.
//

import SwiftUI


class Snake: ObservableObject {
    @Published var direction: Direction = .right
    @Published var snakePositions: [CGPoint]
    @Published var foodPosition: CGPoint
    @Published var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @Published var topScore: Int
    
    @Published var isGameOver: Bool  // Add this line
    
    var snakeSize: CGFloat = 16
    var time:Double = 0.15
    var boolean = true
    
    init() {
        isGameOver = false
        snakePositions = [CGPoint(x: 0 + snakeSize / 2, y: 0 + snakeSize / 2),
                         CGPoint(x: snakeSize + snakeSize / 2, y: 0 + snakeSize / 2),
                         CGPoint(x: snakeSize * 2 + snakeSize / 2, y: 0 + snakeSize / 2)].reversed()
        
        foodPosition = CGPoint(x:snakeSize * 10 + snakeSize / 2, y: snakeSize * 8 + snakeSize / 2)
        topScore = UserDefaults.standard.integer(forKey: "topScoreKey")
        timer = Timer.publish(every: time, on: .current, in: .common).autoconnect()
    }

    
    func move(in geometry: GeometryProxy){
        let containerSize = geometry.size
        var prev = snakePositions[0]
        
        for index in 1..<snakePositions.count {
            if snakePositions[0]==snakePositions[index]{
                reset()
                isGameOver = true
                break
                
            }
        }

        if snakePositions[0].x <= 0 || snakePositions[0].x > containerSize.width ||
                snakePositions[0].y <= 0 || snakePositions[0].y > containerSize.height {
            reset()
            isGameOver = true
        }
        
        
        if snakePositions[0].x == foodPosition.x && snakePositions[0].y == foodPosition.y {
            snakePositions.append(prev)
            setFoodPosition(in: geometry)
        }
        
        if isGameOver {
            updateTopScore()
        }
        
        switch direction {
        case .up:
            snakePositions[0].y -= snakeSize
        case .down:
            snakePositions[0].y += snakeSize
        case .left:
            snakePositions[0].x -= snakeSize
        case .right:
            snakePositions[0].x += snakeSize
        }
        
        for index in 1..<snakePositions.count {
            let current = snakePositions[index]
            snakePositions[index] = prev
            prev = current
        }
        
        
        
    }
    
    func setFoodPosition(in geometry: GeometryProxy) {
        let randomX = Int(Int.random(in: 1..<Int(geometry.size.width)) / Int(snakeSize) ) * Int(snakeSize) + Int(snakeSize/2)
        let randomY = Int(Int.random(in: 1..<Int(geometry.size.height)) / Int(snakeSize) ) * Int(snakeSize) + Int(snakeSize/2)

        foodPosition = CGPoint(x: randomX, y: randomY)
        
        time -= 0.001
        timer = Timer.publish(every: time, on: .current, in: .common).autoconnect()
        
        if snakePositions.count-3 > topScore {
            topScore = snakePositions.count-3
            UserDefaults.standard.set(topScore, forKey: "topScoreKey")
        }
    }
    
    func reset(){
        snakePositions = [CGPoint(x: 0 + snakeSize / 2, y: 0 + snakeSize / 2),
                         CGPoint(x: snakeSize + snakeSize / 2, y: 0 + snakeSize / 2),
                         CGPoint(x: snakeSize * 2 + snakeSize / 2, y: 0 + snakeSize / 2)].reversed()
        
        foodPosition = CGPoint(x:snakeSize * 10 + snakeSize / 2, y: snakeSize * 8 + snakeSize / 2)
        direction = .right
    }
    
    func updateTopScore() {
        if snakePositions.count-3 > topScore {
            topScore = snakePositions.count-3
            UserDefaults.standard.set(topScore, forKey: "topScoreKey")
        }
    }
}
