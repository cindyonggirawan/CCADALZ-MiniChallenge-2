//
//  OnboardingScene.swift
//  Lost Choir
//
//  Created by Celine Margaretha on 30/06/23.
//

import UIKit
import SpriteKit

class OnboardingScene: SKScene {
    
    var blinkingStars: SKSpriteNode!
    var blinkingStarsTexture: [SKTexture] = []
    var blinkingStarsAnimation: SKAction!
    var blinkingStarsAnimationSeq: [SKAction] = []
    
    var member: SKSpriteNode!
    var allMembers: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        //set up blinking stars animation
        blinkingStars = childNode(withName: "blinkingStars") as? SKSpriteNode
        
        let fadeDuration = 2.0
        for idx in 1...4 {
            blinkingStarsTexture.append(SKTexture(imageNamed: "blinkingStars\(idx)"))
            let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
            var setTextureAction: SKAction!
            if idx != 4 {
                setTextureAction = SKAction.setTexture(blinkingStarsTexture[idx-1])
            } else {
                setTextureAction = SKAction.setTexture(blinkingStarsTexture[1])
            }
            let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
            
            
            blinkingStarsAnimationSeq.append(SKAction.sequence([fadeOutAction, setTextureAction, fadeInAction]))
        }
        blinkingStarsTexture.append(blinkingStarsTexture[1])
        blinkingStarsAnimation = SKAction.repeatForever(SKAction.sequence(blinkingStarsAnimationSeq))
        blinkingStars.run(SKAction.repeatForever(blinkingStarsAnimation))
        
        //set up members
        for child in children {
            if child.name!.hasPrefix("member")  {
                if let child = childNode(withName: "\(child.name ?? "noName")") as? SKSpriteNode {
                    allMembers.append(child)
                }
            }
        }
        
        
        //set up breathing
        let breatheOutAction = SKAction.scale(to: 1.01, duration: 3)
        let breatheInAction = SKAction.scale(to: 1.0, duration: 3)
        
        var breathActionSeq = SKAction.sequence([breatheOutAction, breatheInAction])
        for member in allMembers {
            member.run(SKAction.repeatForever(breathActionSeq))
        }
        
        
    }
    
    
    
}
