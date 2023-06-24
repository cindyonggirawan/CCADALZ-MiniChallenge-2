//
//  GameScenePhysics.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 23/06/23.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            print("aaa")
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            print("bbb")
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portalA != 0)) {
            if let player = firstBody.node as? SKSpriteNode,
               let portal = secondBody.node as? SKSpriteNode {
                print("\nMantap")
//                guard let newLayer = Layer2(fileNamed: "Layer2") else {
//                    return
//                }
//                let transition = SKTransition.fade(withDuration: 0.5)
//                view?.presentScene(newLayer, transition: transition)
            }
        }
        
    }
}
