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
    
    let foundMembersLabel = SKLabelNode()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let tileSize: CGFloat = 100.0
    var direction: [Bool] = [false, false, false, false]
    
    let joystickYPos = CGFloat(150)
    
    var lastUpdateTime: TimeInterval = 0

    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // 130 / 2 : CONVERT PIXEL TO POINT!!
    }
    
    var cameraNode = SKCameraNode()
    
    var isPressed: Bool = false
    
    var player = SKSpriteNode(imageNamed: "player")
    var hiddenMembers: [SKSpriteNode] = []
    var foundMembers: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        disk.position = CGPoint(x: screenWidth / 2, y: joystickYPos)
        disk.alpha = 0.3
        disk.addChild(knob)
        knob.zPosition = 2
        
        knob.position = CGPoint(x: 0, y: 0)
        addChild(disk)
        
        //create player
        player.anchorPoint = CGPointZero
        player.name = "player"
        player.setScale(0.5)
        player.position = CGPoint(x: 0, y: -300)
        addChild(player)
        
        debugDrawPlayableArea()
        
        //hidden members position
        spawnHiddenMembers()
        
        //camera
        camera = cameraNode
        cameraNode.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        
        //label generator
//        generatefoundMembersLabel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveFoundMembers()
        
        camera?.position.x = player.position.x
        foundMembersLabel.position.x = (camera?.position.x)!
        camera?.position.y = player.position.y
        foundMembersLabel.position.y = (camera?.position.y)!
    }
    
    override func didEvaluateActions() {
        checkCollisions()
    }
    
    func spawnHiddenMembers() {
        for i in 0...2 {
            hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)"))
            hiddenMembers[i].anchorPoint = CGPointZero
            hiddenMembers[i].name = "hidden member"
            hiddenMembers[i].setScale(0.5)
            if i == 0 {
                hiddenMembers[i].position = CGPoint(x: -100, y: 0)
            } else if i == 1 {
                hiddenMembers[i].position = CGPoint(x: 100, y: -200)
            } else {
                hiddenMembers[i].position = CGPoint(x: 300, y: 200)
            }
            
            addChild(hiddenMembers[i])
        }
    }
    
    func generatefoundMembersLabel() {
        foundMembersLabel.text = "Members Collected: 0"
        foundMembersLabel.fontColor = SKColor.black
        foundMembersLabel.fontSize = 20
        foundMembersLabel.zPosition = 999
        foundMembersLabel.horizontalAlignmentMode = .left
        foundMembersLabel.verticalAlignmentMode = .bottom
        foundMembersLabel.position = CGPoint.zero
        addChild(foundMembersLabel)
    }
    
    func checkCollisions() {
        var foundMembers: [SKSpriteNode] = []
        enumerateChildNodes(withName: "hidden member") { node, _ in
            let member = node as! SKSpriteNode
            if CGRectIntersectsRect(member.frame, self.player.frame) {
                foundMembers.append(member)
            }
        }
        
        for member in foundMembers {
            print("a member found")
            collectHiddenMember(member: member)
        }
    }
    
    func collectHiddenMember(member: SKSpriteNode) {
//        member.removeFromParent()
        member.name = "found member"
        GameData.shared.numberOfMembersCollected += 1
        foundMembersLabel.text = "Members Found: \(GameData.shared.numberOfMembersCollected)"
        
        let turnGreen = SKAction.colorize(with: SKColor.green, colorBlendFactor: 1.0, duration: 0.2)
        member.run(turnGreen)
    }
    
    func moveFoundMembers() {
        var targetPosition = player.position
        
        enumerateChildNodes(withName: "found member") { node, stop in
            if !node.hasActions() {
                print("target position 1: \(targetPosition)")
                let actionDuration = 0.3
                let moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
                
                node.run(moveAction)
            }
            
            targetPosition = node.position
            print("target position 2: \(targetPosition)")
            print("player position: \(self.player.position)")
        }
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
                
                switch tangent2 {
                // >>> UP
                case (Double.pi / 4) ..< (3 * Double.pi / 4):
                    player.zRotation = CGFloat(Double.pi) / 2.0
                    print("up")
                    
                // >>> LEFT
                case (3 * Double.pi / 4) ... Double.pi:
                    player.zRotation = CGFloat(Double.pi) / 1.0
                    print("left-1")
                case (-1 * Double.pi) ... (-3 * Double.pi / 4):
                    player.zRotation = CGFloat(Double.pi) / 1.0
                    print("left-2")
                    
                // >>> DOWN
                case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
                    player.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
                    print("down")
                    
                // >>> RIGHT
                case (-1 * Double.pi / 4) ... 0 :
                    player.zRotation = 0
                    print("right-2")
                case 0 ..< (Double.pi / 4):
                    player.zRotation = 0
                    print("right-1")
                    
                default:
                    print("mantap")
                }
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
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
}
