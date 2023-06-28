//
//  GameScenePhysics.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 23/06/23.
//

import Foundation
import UIKit
import SpriteKit

//extension GameScene: SKPhysicsContactDelegate {
//
//    func didBegin(_ contact: SKPhysicsContact) {
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//
//        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portalA != 0)) {
//            if let _ = firstBody.node as? SKSpriteNode,
//               let _ = secondBody.node as? SKSpriteNode {
//                guard let newLayer = GameScene1_2(fileNamed: "Layer2") else {
//                    return
//                }
//                let transition = SKTransition.fade(withDuration: 1)
//                GameData.shared.audioHelper.playTeleportSound()
//                view?.presentScene(newLayer, transition: transition)
//            }
//        }
//
//        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.wall != 0)) {
//            print("\nwall contacted!")
//        }
//
//    }
//}

extension GameScene1_2: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portalA != 0)) {
            if let _ = firstBody.node as? SKSpriteNode,
               let _ = secondBody.node as? SKSpriteNode {
                guard let newLayer = GameScene1_2(fileNamed: "GameScene1_2") else {
                    return
                }
                let transition = SKTransition.fade(withDuration: 1)
                GameData.shared.audioHelper.playTeleportSound()
                view?.presentScene(newLayer, transition: transition)
            }
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.wall != 0)) {
            print("\nwall contacted!")
        }
        
    }
}

extension GameScene1_1: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portalA != 0)) {
            if let _ = firstBody.node as? SKSpriteNode,
               let _ = secondBody.node as? SKSpriteNode {
                guard let newLayer = GameScene1_2(fileNamed: "GameScene1_2") else {
                    return
                }
                let transition = SKTransition.fade(withDuration: 1)
                GameData.shared.audioHelper.playTeleportSound()
                view?.presentScene(newLayer, transition: transition)
            }
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.wall != 0)) {
            print("\nwall contacted!")
        }
        
    }
}
//
