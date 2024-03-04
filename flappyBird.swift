//
//  flappyBird.swift
//  NexWell.
//
//  Created by Keoni Li on 8/18/23.
//

import SwiftUI
import SpriteKit

class flapFlap: SKScene {
    
     override func didMove(to view: SKView) {
     physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
     }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     guard let touch = touches.first else { return }
     let location = touch.location(in: self)
     
     let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
     box.position = location
     box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
     
     addChild(box)
     
     }
}

struct flappyBird: View {
    var scene: SKScene {
        let scene = flapFlap()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 400)
    }
}

struct flappyBird_Previews: PreviewProvider {
    static var previews: some View {
        flappyBird()
    }
}
