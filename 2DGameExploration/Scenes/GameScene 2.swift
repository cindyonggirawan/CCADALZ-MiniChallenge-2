//
//  GameScene.swift
//  2DGameExploration
//
//  Created by Cindy Amanda Onggirawan on 19/06/23.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    var level1: SKLabelNode!
    var level2: SKLabelNode!
    
    override func didMove(to view: SKView) {
        level1 = childNode(withName: "level1") as? SKLabelNode
        level2 = childNode(withName: "level2") as? SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        // PRESENT LEVEL 1
        if level1.contains(touchLocation) {
            guard let layer1 = Layer1(fileNamed: "Layer1") else { return }
            let transition = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(layer1, transition: transition)
        }
        
        // PRESENT LEVEL 2
        if level2.contains(touchLocation) {
//            guard let layer2 = Layer2(fileNamed: "Layer2") else { return }
//            let transition = SKTransition.fade(withDuration: 0.5)
//            view?.presentScene(layer2, transition: transition)
        }

    }
    
}
