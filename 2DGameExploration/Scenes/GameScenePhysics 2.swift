//
//  GameScenePhysics.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 23/06/23.
//

import Foundation
import UIKit
import SpriteKit

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
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portal != 0)) {
            if let _ = firstBody.node as? SKSpriteNode,
               let _ = secondBody.node as? SKSpriteNode {
                GameData.shared.gamefirstStarted = false
                
                guard let layer2 = GameScene1_2(fileNamed: "GameScene1_2") else { return }
                let transition = SKTransition.fade(withDuration: 1)
                GameData.shared.audioHelper.playTeleportSound()
                view?.presentScene(layer2, transition: transition)
            }
        }
    }
}

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
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portal != 0)) {
            if let first = firstBody.node as? SKSpriteNode,
               let second = secondBody.node as? SKSpriteNode {
                guard let layer1 = GameScene1_1(fileNamed: "GameScene1_1") else { return }
                guard let layer3 = GameScene1_1(fileNamed: "GameScene1_3") else { return }
                
                let transition = SKTransition.fade(withDuration: 1)
                GameData.shared.audioHelper.playTeleportSound()
                
                if let portalName = second.name {
                    if portalName == "portal1" {
                        GameData.shared.gamefirstStarted = false
                        
                        view?.presentScene(layer1, transition: transition)
                    } else if portalName == "portal2" {
                        view?.presentScene(layer3, transition: transition)
                    }
                }
                
                
                
            }
        }
        
    }
}

extension GameScene1_3: SKPhysicsContactDelegate {
    
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
        
        if ((firstBody.categoryBitMask & PhysicsCategory.player != 0) && (secondBody.categoryBitMask & PhysicsCategory.portal != 0)) {
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
    }
}
