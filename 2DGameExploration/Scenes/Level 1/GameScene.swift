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
    
    let membersCollectedLabel = SKLabelNode()
    var numberOfMembersCollected: Int = 0
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let joystickYPos = CGFloat(150)
    
    var lastUpdateTime: TimeInterval = 0

    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // 130 / 2 : CONVERT PIXEL TO POINT!!
    }
    
    var cameraScene = SKCameraNode()
    
    var isPressed: Bool = false
    
    var player: SKSpriteNode!
    var hiddenMembers: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        
        camera = cameraScene
        
        disk.position = CGPoint(x: screenWidth/2, y: joystickYPos)
        disk.alpha = 0.3
        disk.addChild(knob)
        knob.zPosition = 2
        
        knob.position = CGPoint(x: 0, y: 0)
        addChild(disk)
        
        let texture = SKTexture(imageNamed: "up")
        player  = SKSpriteNode(texture: texture)
        player.position = CGPoint(x: screenWidth/2, y: 350)
        addChild(player)
        
        //hidden members position set up
        spawnHiddenMembers()
        
        //label generator
        generateMembersCollectedLabel()
    }
    
    func spawnHiddenMembers() {
        for i in 0...2 {
            hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)"))
            hiddenMembers[i].anchorPoint = CGPointZero
            hiddenMembers[i].name = "member"
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
    
    func generateMembersCollectedLabel() {
        membersCollectedLabel.text = "Members Collected: 0"
        membersCollectedLabel.fontColor = SKColor.black
        membersCollectedLabel.fontSize = 20
        membersCollectedLabel.zPosition = 999
        membersCollectedLabel.horizontalAlignmentMode = .left
        membersCollectedLabel.verticalAlignmentMode = .bottom
        membersCollectedLabel.position = CGPoint(x: 0, y: 0)
        
        addChild(membersCollectedLabel)
    }
    
    func checkCollisions() {
        var membersCollected: [SKSpriteNode] = []
        enumerateChildNodes(withName: "member") { node, _ in
            let member = node as! SKSpriteNode
            if CGRectIntersectsRect(member.frame, self.player.frame) {
                membersCollected.append(member)
            }
        }
        
        for member in membersCollected {
            print("a member found")
            collectHiddenMember(member: member)
        }
    }
    
    func collectHiddenMember(member: SKSpriteNode) {
        member.removeFromParent()
        GameData.shared.numberOfMembersCollected += 1
        membersCollectedLabel.text = "Members Collected: \(GameData.shared.numberOfMembersCollected)"
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
                
                switch tangent2 {
                // >>> UP
                case (Double.pi / 4) ..< (3 * Double.pi / 4):
                    let texture = SKTexture(imageNamed: "up")
                    player.texture = texture
                    print("up")
                    
                    
                // >>> LEFT
                case (3 * Double.pi / 4) ... Double.pi:
                    print("left-1")
                    let texture = SKTexture(imageNamed: "left")
                    player.texture = texture
                case (-1 * Double.pi) ... (-3 * Double.pi / 4):
                    print("left-2")
                    let texture = SKTexture(imageNamed: "left")
                    player.texture = texture
                    
                // >>> DOWN
                case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
                    print("down")
                    let texture = SKTexture(imageNamed: "down")
                    player.texture = texture
                    
                // >>> RIGHT
                case (-1 * Double.pi / 4) ... 0 :
                    print("right-2")
                    let texture = SKTexture(imageNamed: "right")
                    player.texture = texture
                case 0 ..< (Double.pi / 4):
                    print("right-1")
                    let texture = SKTexture(imageNamed: "right")
                    player.texture = texture
                    
                default:
                    print("mantap")
                }
                
                
//                switch tangent2 {
//                case (Double.pi / 4) ... (3 * Double.pi / 4):
//                    player = SKSpriteNode(imageNamed: "up")
//                    print("up")
//                case (-3 * Double.pi / 4) ... (3 * Double.pi / 4):
//                    player = SKSpriteNode(imageNamed: "left")
//                    print("left")
//                case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
//                    player = SKSpriteNode(imageNamed: "right")
//                    print("right")
//                case (-1  * Double.pi / 4) ... (Double.pi / 4):
//                    player = SKSpriteNode(imageNamed: "down")
//                    print("down")
//                default:
//                    player = SKSpriteNode(imageNamed: "up")
//                    print("mantap")
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
    
    override func update(_ currentTime: TimeInterval) {
        camera?.position.x = player.position.x
        membersCollectedLabel.position.x = (camera?.position.x)!
        camera?.position.y = player.position.y
        membersCollectedLabel.position.y = (camera?.position.y)!
    }
    
    override func didEvaluateActions() {
        checkCollisions()
    }
}
