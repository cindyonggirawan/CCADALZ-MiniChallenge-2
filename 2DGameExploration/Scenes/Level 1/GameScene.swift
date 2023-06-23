//
//  GameScene.swift
//  2DGameExploration
//
//  Created by Cindy Amanda Onggirawan on 19/06/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // TO GET JOYSTICK FROM GAMESCENE.SKS
    var disk: SKSpriteNode!
    var knob: SKSpriteNode!
    
    let foundMembersLabel = SKLabelNode()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var tileSize = CGSize(width: 40, height: 40) // ganti ukuran persegi ke ukuran hasil export asset dari figma
    
    let joystickYPos = CGFloat(150)
    
    var lastDragGesture: String = ""

    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // 130 / 2 : CONVERT PIXEL TO POINT!!
    }
    
    var cameraNode = SKCameraNode()
    
    var isPressed: Bool = false
    
    var player: SKSpriteNode!
    var hiddenMembers: [SKSpriteNode] = []
    var foundMembers: [SKSpriteNode] = []
    
    var availableSpots = [CGPoint]()
    
    override func didMove(to view: SKView) {
        disk = childNode(withName: "disk") as? SKSpriteNode
        knob = disk.childNode(withName: "knob") as? SKSpriteNode
        
        disk.alpha = 0
        knob.zPosition = 2
        
        //create player
        player = childNode(withName: "player") as! SKSpriteNode
        player.name = "player"
//        player.setScale(0.5)
//        player.anchorPoint = CGPointZero // dia jadi posisi kuadran, agak membingungkan
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        player.position = CGPoint(x: 50, y: -350)
//        addChild(player)
        
//        debugDrawPlayableArea()
        
        // hidden members position
        spawnHiddenMembers()
        
        // camera
        camera = cameraNode
        cameraNode.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        
        // label generator
        generatefoundMembersLabel()
        
        // tile map
        for node in self.children {
            if node is SKTileMapNode {
                if let theMap: SKTileMapNode = node as? SKTileMapNode {
                    setUpSceneWithMap(map: theMap)
                }
            }
        }
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
            hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
            hiddenMembers[i].name = "hidden member"
//            hiddenMembers[i].setScale(0.5)
            hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            if i == 0 {
                hiddenMembers[i].position = CGPoint(x: -60, y: 8)
            } else if i == 1 {
                hiddenMembers[i].position = CGPoint(x: 180, y: -234)
            } else {
                hiddenMembers[i].position = CGPoint(x: -180, y: 86)
            }
            
            addChild(hiddenMembers[i])
        }
    }
    
    func generatefoundMembersLabel() {
        foundMembersLabel.text = "Members Found: 0"
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
            print("a member is found")
            findHiddenMember(member: member)
        }
    }
    
    func findHiddenMember(member: SKSpriteNode) {
        member.name = "found member"
        
        for i in 0..<3 {
            if member == hiddenMembers[i] {
                GameData.shared.numberOfFoundMembers += 1
                GameData.shared.foundStatusOfFoundMembers[i] = true
                GameData.shared.indexOrderOfFoundMembers.append(i)
            }
        }
        
        foundMembersLabel.text = "Members Found: \(GameData.shared.numberOfFoundMembers)"
        
        let turnGreen = SKAction.colorize(with: SKColor.green, colorBlendFactor: 1.0, duration: 0.2)
        member.run(turnGreen)
    }
    
    func moveFoundMembers() {
        var targetPosition = player.position
        let actionDuration = 0.3
        var moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
        let offset = [CGPoint(x: 0, y: -tileSize.height), CGPoint(x: tileSize.width, y: 0), CGPoint(x: 0, y: tileSize.height), CGPoint(x: -tileSize.width, y: 0)]
        var memberName = ""
        
        enumerateChildNodes(withName: "found member") { node, stop in
            if !node.hasActions() {
                let member = node as! SKSpriteNode
                
                for i in 0..<3 {
                    if member == self.hiddenMembers[i] {
                        memberName = "member\(i)"
                        break
                    }
                }
                
                if self.lastDragGesture == "up" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0
                    member.texture = SKTexture(imageNamed: "\(memberName)_up")
                    moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
                } else if self.lastDragGesture == "left" {
//                    node.zRotation = CGFloat(Double.pi) / 1.0
                    member.texture = SKTexture(imageNamed: "\(memberName)_left")
                    moveAction = SKAction.move(to: targetPosition + offset[1], duration: actionDuration)
                } else if self.lastDragGesture == "down" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
                    member.texture = SKTexture(imageNamed: "\(memberName)_down")
                    moveAction = SKAction.move(to: targetPosition + offset[2], duration: actionDuration)
                } else if self.lastDragGesture == "right" {
//                    node.zRotation = 0
                    member.texture = SKTexture(imageNamed: "\(memberName)_right")
                    moveAction = SKAction.move(to: targetPosition + offset[3], duration: actionDuration)
                }
                
                node.run(moveAction)
            }
            
            // member selanjutnya berada dibelakang member pertama
            targetPosition = node.position
        }
    }
    
    func setUpSceneWithMap(map: SKTileMapNode) {
        let tileMap = map
        tileSize = tileMap.tileSize
        
        print("row: \(tileMap.numberOfRows), col: \(tileMap.numberOfColumns)")
        
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let _ = tileMap.tileDefinition(atColumn: col, row: row) {
                    // ada tembok
                } else {
                    // tidak ada tembok (bisa jalan)
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width) / 2
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height) / 2
                    
                    print("its a land in \(x) and \(y)")
                    
                    let newPoint: CGPoint = CGPoint(x: x, y: y)
                    
                    let newPointConverted: CGPoint = self.convert(newPoint, from: tileMap)
                    
                    availableSpots.append(newPointConverted)
                    // terus diapain yaaa
                }
            }
        }
    }
    
    // _ angle: CGFloat, _ diskLocation: CGPoint, _ radiusTemp: Double
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let diskLocation = touch.location(in: disk) // diskLocation
            let _ = touch.location(in: knob) // knobLocation
            
            disk.position = location
            disk.alpha = 0.4
            
            if disk.contains(location) {
                self.isPressed = true
            }

//            let _: Double = diskLocation.x
//            let _: Double = diskLocation.y
//            
//            let _: CGFloat = atan2(yDiskLoc, xDiskLoc) // solusi pertama arctan(y/x)
//            let _ = sqrt(pow(xDiskLoc, 2) + pow(yDiskLoc, 2))

//            joyStick(location, angle, diskLocation, radiusTemp)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let diskLocation = touch.location(in: disk)
            let _ = touch.location(in: knob) // knobLocation

            let xDiskLoc: Double = diskLocation.x
            let yDiskLoc: Double = diskLocation.y
            
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

                // nanti kalo asetnya sudah lengkap, bisa langsung pakai texture
                switch angle {
                // >>> UP
                case (Double.pi / 4) ..< (3 * Double.pi / 4):
//                    player.zRotation = CGFloat(Double.pi) / 2.0
                    player.texture = SKTexture(imageNamed: "player_up")
                    lastDragGesture = "up"
        //                    print("up")

                // >>> LEFT
                case (3 * Double.pi / 4) ... Double.pi:
//                    player.zRotation = CGFloat(Double.pi) / 1.0
                    player.texture = SKTexture(imageNamed: "player_left")
                    lastDragGesture = "left"
        //                    print("left-1")
                case (-1 * Double.pi) ... (-3 * Double.pi / 4):
//                    player.zRotation = CGFloat(Double.pi) / 1.0
                    player.texture = SKTexture(imageNamed: "player_left")
                    lastDragGesture = "left"
        //                    print("left-2")

                // >>> DOWN
                case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
//                    player.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
                    player.texture = SKTexture(imageNamed: "player_down")
                    lastDragGesture = "down"
        //                    print("down")

                // >>> RIGHT
                case (-1 * Double.pi / 4) ... 0 :
//                    player.zRotation = 0
                    player.texture = SKTexture(imageNamed: "player_right")
                    lastDragGesture = "right"
        //                    print("right-2")
                case 0 ..< (Double.pi / 4):
//                    player.zRotation = 0
                    player.texture = SKTexture(imageNamed: "player_right")
                    lastDragGesture = "right"
        //                    print("right-1")

                default:
                    lastDragGesture = ""
        //                    print("mantap")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = false
        disk.alpha = 0
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    
    
    
    
    
    
    
    
    
//    func joyStick(_ location: CGPoint, _ angle: CGFloat, _ diskLocation: CGPoint, _ radiusTemp: Double) {
//        if radiusTemp < diskRadius {
//            knob.position = diskLocation
//        } else {
//            knob.position = diskLocation
//            disk.position = CGPoint(x: location.x - diskRadius * cos(angle), y: location.y - diskRadius * sin(angle))
//        }
//
//        player.position.x += diskLocation.x * 0.08
//        player.position.y += diskLocation.y * 0.08
//
//        // nanti kalo asetnya sudah lengkap, bisa langsung pakai texture
//        switch angle {
//        // >>> UP
//        case (Double.pi / 4) ..< (3 * Double.pi / 4):
//            player.zRotation = CGFloat(Double.pi) / 2.0
//            lastDragGesture = "up"
////                    print("up")
//
//        // >>> LEFT
//        case (3 * Double.pi / 4) ... Double.pi:
//            player.zRotation = CGFloat(Double.pi) / 1.0
//            lastDragGesture = "left"
////                    print("left-1")
//        case (-1 * Double.pi) ... (-3 * Double.pi / 4):
//            player.zRotation = CGFloat(Double.pi) / 1.0
//            lastDragGesture = "left"
////                    print("left-2")
//
//        // >>> DOWN
//        case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
//            player.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
//            lastDragGesture = "down"
////                    print("down")
//
//        // >>> RIGHT
//        case (-1 * Double.pi / 4) ... 0 :
//            player.zRotation = 0
//            lastDragGesture = "right"
////                    print("right-2")
//        case 0 ..< (Double.pi / 4):
//            player.zRotation = 0
//            lastDragGesture = "right"
////                    print("right-1")
//
//        default:
//            lastDragGesture = ""
////                    print("mantap")
//        }
//    }
}
