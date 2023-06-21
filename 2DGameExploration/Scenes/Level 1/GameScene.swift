//
//  GameScene.swift
//  2DGameExploration
//
//  Created by Cindy Amanda Onggirawan on 19/06/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let disk = SKSpriteNode(imageNamed: "disk")
    let knob = SKSpriteNode(imageNamed: "knob")
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let joystickYPos = CGFloat(150)
    
    var lastUpdateTime: TimeInterval = 0

    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // 130 / 2 : CONVERT PIXEL TO POINT!!
    }
    
    var isPressed: Bool = false
    
    var player = SKSpriteNode(imageNamed: "up")
    
    override func didMove(to view: SKView) {
        disk.position = CGPoint(x: screenWidth/2, y: joystickYPos)
        disk.alpha = 0.3
        disk.addChild(knob)
        knob.zPosition = 2
        
        knob.position = CGPoint(x: 0, y: 0)
        addChild(disk)
        
        player = SKSpriteNode(imageNamed: "up")
        player.position = CGPoint(x: screenWidth/2, y: 350)
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let _ = touch.location(in: disk) // diskLocation
            let _ = touch.location(in: knob) // knobLocation
            
            disk.position = location
            disk.alpha = 1
            
            if disk.contains(location) {
                self.isPressed = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let diskLocation = touch.location(in: disk)
            let _ = touch.location(in: knob) // knobLocation

            let xDiskLoc: Double = diskLocation.x
            let yDiskLoc: Double = diskLocation.y
            
            let tangent2 = atan2(yDiskLoc, xDiskLoc)
            
            let angle: CGFloat = atan2(yDiskLoc, xDiskLoc) // solusi pertama arctan(y/x)
            let radiusTemp = sqrt(pow(xDiskLoc, 2) + pow(yDiskLoc, 2))

            if self.isPressed {
                if radiusTemp < diskRadius {
                    knob.position = diskLocation
                } else {
                    knob.position = diskLocation
                    disk.position = CGPoint(x: location.x - diskRadius * cos(angle), y: location.y - diskRadius * sin(angle))
                }
                
                player.position.x += diskLocation.x * 0.08
                player.position.y += diskLocation.y * 0.08
                
//                print("aaa", atan(yDiskLoc / xDiskLoc))
//                print("bbb", tangent2)
//                print()
                
//                switch {
//                    case
//                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let moveDisk = SKAction.move(to: CGPoint(x: screenWidth/2, y: joystickYPos), duration: 0.08)
        let moveKnob = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.08)
        knob.run(moveKnob)
        disk.run(moveDisk)
        self.isPressed = false
        disk.alpha = 0.3
        
    }
    
    override func update(_ currentTime: TimeInterval) {}
}
