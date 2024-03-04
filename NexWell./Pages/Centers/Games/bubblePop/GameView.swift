//
//  GameView.swift
//  NexWell.
//
//  Created by Keoni Li on 11/13/23.
//

import SwiftUI
import AVFoundation
import SpriteKit
import UIKit

struct GameView: View {
    
    @Environment(\.dismiss) private var dismiss

    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            SpriteView(scene: scene)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
                .offset(y: UIScreen.main.bounds.height * 0.04)
            
            Button(action: { dismiss() } ) {
                                ZStack {
                                    regRR(widthDiv: 8, heightDiv: 20, color: .pink, text: "Exit", tColor: .white)
                                }
                                
                                    
                            }
            .offset(y: UIScreen.main.bounds.height/3 - 55)
            
        }
        
    }
}
    

class GameScene: SKScene {
    
    let colors = [SKColor.red, SKColor.yellow, SKColor.green, SKColor.orange, SKColor.purple, SKColor.systemPink, SKColor.systemBlue]
    
    override func didMove(to view: SKView) {
        // Setup your scene
        backgroundColor = SKColor.black
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // No gravity in the scene
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            // Handle touch events
            if let touch = touches.first {
                let location = touch.location(in: self)
                createBubble(at: location)
            }
        }
    
    func createBubble(at position: CGPoint) {
        let randomRadius = CGFloat.random(in: 30...70) // Random radius between 10 and 40
        let bubble = SKShapeNode(circleOfRadius: randomRadius)
        bubble.position = position
        
        // Randomly select a color for the bubble
        let randomColorIndex = Int.random(in: 0..<colors.count)
        bubble.fillColor = colors[randomColorIndex]
        bubble.strokeColor = SKColor.clear
        
        // Add physics body for the bubble if you want to add some dynamics
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: randomRadius)
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.affectedByGravity = false
        
        // Add the bubble to the scene
        addChild(bubble)
        
        // Define actions for the bubble
        let moveUpAction = SKAction.moveBy(x: 0, y: size.height + bubble.frame.size.height, duration: Double.random(in: 4...8))
        let fadeOutAction = SKAction.fadeOut(withDuration: Double.random(in: 4...8))
        let removeAction = SKAction.removeFromParent()
        
        // Combine actions into a sequence: move up and fade out, then remove
        let sequenceAction = SKAction.sequence([SKAction.group([moveUpAction, fadeOutAction]), removeAction])
        
        bubble.run(sequenceAction)
    }
}



#Preview {
    GameView()
}
