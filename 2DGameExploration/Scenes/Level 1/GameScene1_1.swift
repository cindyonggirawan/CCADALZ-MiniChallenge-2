//
//  GameScene1_1.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 28/06/23.
//

import SpriteKit
import AVFoundation

class GameScene1_1: SKScene {
    // TO GET JOYSTICK FROM GAMESCENE.SKS
    var disk: SKSpriteNode!
    var knob: SKSpriteNode!
    var location: CGPoint = .zero
    var diskLocation: CGPoint = .zero
    var angle: CGFloat = 0.0
    
    var portalA: SKSpriteNode!
    
    let foundMembersLabel = SKLabelNode()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var tileSize = CGSize(width: 40, height: 40) // ganti ukuran persegi ke ukuran hasil export asset dari figma
    
    let joystickYPos = CGFloat(150)
    
    var lastDragGesture: String = "down"
    var beforeLastDragGesture: String = "down"

    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // 130 / 2 : CONVERT PIXEL TO POINT!!
    }
    
    var cameraNode = SKCameraNode()
    
    var isPressed: Bool = false
    
    var player: SKSpriteNode!
    var playerAnimation: SKAction!
    
    var playerXPos: Double = 0.0
    var playerYPos: Double = 0.0
    
    var didContactWall: Bool = false
    
    var hiddenMembers: [SKSpriteNode] = []
    var foundMembers: [SKSpriteNode] = []
    
    var availableSpots = [CGPoint]()
    
    var layerTile: SKTileMapNode!
    var figma: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self // aktifkan tenaga dalam!
        
        disk = childNode(withName: "disk") as? SKSpriteNode
        knob = disk.childNode(withName: "knob") as? SKSpriteNode
        
        portalA = childNode(withName: "portalA") as? SKSpriteNode
        
        disk.alpha = 0
        knob.zPosition = 2
        
        //create player
        player = childNode(withName: "player") as? SKSpriteNode
        player.name = "player"
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        player.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: 56, height: 26),
            center: CGPoint(x: 0, y: -30)
        )
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.portalA | PhysicsCategory.wall
        player.physicsBody?.collisionBitMask = PhysicsCategory.wall
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.restitution = 0
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.linearDamping = 1
        
        // PORTAL CONTACT TEST
        portalA.physicsBody = SKPhysicsBody(rectangleOf: portalA.size)
        portalA.physicsBody?.isDynamic = true
        portalA.physicsBody?.categoryBitMask = PhysicsCategory.portalA
        portalA.physicsBody?.contactTestBitMask = PhysicsCategory.player
        portalA.physicsBody?.collisionBitMask = PhysicsCategory.none// hidden members position
        
        //animasi player
        var textures: [SKTexture] = []
        for i in 0..<2 {
            textures.append(SKTexture(imageNamed: "player_down_animation\(i)"))
        }
        playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        spawnHiddenMembers()
        
//         debugDrawPlayableArea()
        
        // camera
        camera = cameraNode
        cameraNode.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        
//        // tile map
//        for node in self.children {
//            if node is SKTileMapNode {
//                if let theMap: SKTileMapNode = node as? SKTileMapNode {
//                    setUpSceneWithMap(map: theMap)
//                    print("Tile \(theMap.a)")
//                }
//            }
//        }
        
        // get tilemap from .sks
        layerTile = childNode(withName: "WallTilesMap") as? SKTileMapNode

        setUpMapPhysics(layerTile)
        print("Wall \(layerTile.anchorPoint.x), \(layerTile.anchorPoint.y)")
        
//        figma = childNode(withName: "Tile Map Node") as? SKTileMapNode
        
//        print("Layer \(figma.anchorPoint.x), \(figma.anchorPoint.y)")
//        camera?.position.x = player.position.x
//        camera?.position.y = player.position.y
        
        let audioFileNames = ["level1_bgm.mp3", "level1_voice1.mp3", "level1_voice2.mp3", "level1_voice3.mp3", "level1_voice4.mp3"]
        for fileName in audioFileNames {
            if let audioPlayer = loadAudioPlayer(fileName: fileName) {
                GameData.shared.audioPlayers.append(audioPlayer)
            }
        }
        
        playAllAudioTracks()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveFoundMembers()

        camera?.position.x = player.position.x
        camera?.position.y = player.position.y
        
        foundMembersLabel.position.x = (camera?.position.x)!
        foundMembersLabel.position.y = (camera!.position.y + 300.0)
        
        
        if self.isPressed {
            rotatePlayer(location, diskLocation, angle)
//            disk.position.x = CGFloat(disk.position.x + diskLocation.x * 0.015)
//            disk.position.y = CGFloat(disk.position.y + diskLocation.y * 0.015)
            disk.position = CGPoint(x: camera!.position.x, y: camera!.position.y - 250)
        }
        
        if GameData.shared.isEnded == false {
            let duration = GameData.shared.audioPlayers.first!.duration
            let delay = duration + 1
            run(SKAction.sequence([
                SKAction.wait(forDuration: delay),
                SKAction.run {
                    playAllAudioTracks()
                }
            ]))
        }
    }
    
    override func didEvaluateActions() {
        checkCollisions()
    }
    
    func startPlayerAnimation() {
        if player.action(forKey: "animation") == nil {
            player.run(SKAction.repeatForever(playerAnimation),
                        withKey: "animation")
        }
    }
    
    func stopPlayerAnimation() {
        player.removeAction(forKey: "animation")
    }
    
    func spawnHiddenMembers() {
        for i in 0...2 {
            hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
            hiddenMembers[i].name = "hidden member"
            hiddenMembers[i].zPosition = CGFloat(i + 10)
//            hiddenMembers[i].setScale(0.5)
            hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            if i == 0 {
                hiddenMembers[i].position = CGPoint(x: -45, y: 8)
                hiddenMembers[i].physicsBody = SKPhysicsBody(
                    rectangleOf: CGSize(width: 56, height: 26),
                    center: CGPoint(x: -1, y: -35)
                )
            } else if i == 1 {
                hiddenMembers[i].position = CGPoint(x: 140, y: -234)
                hiddenMembers[i].physicsBody = SKPhysicsBody(
                    rectangleOf: CGSize(width: 56, height: 26),
                    center: CGPoint(x: -1, y: -35)
                )
            } else {
                hiddenMembers[i].position = CGPoint(x: -165, y: 116)
                hiddenMembers[i].physicsBody = SKPhysicsBody(
                    rectangleOf: CGSize(width: 56, height: 27),
                    center: CGPoint(x: 0, y: -36)
                )
            }
            
//            hiddenMembers[i].physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: hiddenMembers[i].size.width - 50, height: hiddenMembers[i].size.height - 40))
            
            hiddenMembers[i].physicsBody?.isDynamic = true
            hiddenMembers[i].physicsBody?.allowsRotation = false
            hiddenMembers[i].physicsBody?.categoryBitMask = PhysicsCategory.hiddenMember
            hiddenMembers[i].physicsBody?.contactTestBitMask = PhysicsCategory.wall
            hiddenMembers[i].physicsBody?.collisionBitMask = PhysicsCategory.wall
            
            addChild(hiddenMembers[i])
        }
    }
    
    func generatefoundMembersLabel() {
        foundMembersLabel.text = "Members Found: 0"
        foundMembersLabel.fontColor = SKColor.lightGray
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
//            print("a member is found")
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
                
                adjustVolume()
            }
        }
        
        foundMembersLabel.text = "Members Found: \(GameData.shared.numberOfFoundMembers)"
        
//        let turnGreen = SKAction.colorize(with: SKColor.green, colorBlendFactor: 1.0, duration: 0.2)
//        member.run(turnGreen)
    }
    
    func moveFoundMembers() {
        var targetPosition = player.position
        let actionDuration = 0.3
        var moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
        let offset = [
            CGPoint(x: 0, y: -tileSize.height),
            CGPoint(x: tileSize.width, y: 0),
            CGPoint(x: 0, y: tileSize.height),
            CGPoint(x: -tileSize.width, y: 0)
        ]
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
//                    moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
                } else if self.lastDragGesture == "left" {
//                    node.zRotation = CGFloat(Double.pi) / 1.0
                    member.texture = SKTexture(imageNamed: "\(memberName)_left")
                    moveAction = SKAction.move(to: targetPosition + offset[1], duration: actionDuration)
//                    moveAction = SKAction.move(to: targetPosition + offset[1], duration: actionDuration)
                } else if self.lastDragGesture == "down" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
                    member.texture = SKTexture(imageNamed: "\(memberName)_down")
                    moveAction = SKAction.move(to: targetPosition + offset[2], duration: actionDuration)
//                    moveAction = SKAction.move(to: targetPosition + offset[2], duration: actionDuration)
                } else if self.lastDragGesture == "right" {
//                    node.zRotation = 0
                    member.texture = SKTexture(imageNamed: "\(memberName)_right")
                    moveAction = SKAction.move(to: targetPosition + offset[3], duration: actionDuration)
//                    moveAction = SKAction.move(to: targetPosition + offset[3], duration: actionDuration)
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
                    
//                    let xx = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width) / 2
                    
//                    print("its a land in \(x) and \(y)\n")
                    
                    let newPoint: CGPoint = CGPoint(x: x, y: y)
                    
                    let newPointConverted: CGPoint = self.convert(newPoint, from: tileMap)
                    
                    availableSpots.append(newPointConverted)
                    // terus diapain yaaa
                }
            }
        }
    }
        
    func setUpMapPhysics(_ tileMap: SKTileMapNode) {
        let tileSize = tileMap.tileSize
        
        let halfWidth = (CGFloat(tileMap.numberOfColumns) / 2.0) * tileSize.width
        let halfHeight = (CGFloat(tileMap.numberOfRows) / 2.0) * tileSize.width
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let mantap = tileMap.tileDefinition(atColumn: col, row: row) {
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width) / 2
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height) / 2
                    
                    
                    let tembok = SKShapeNode(rectOf: CGSize(width: tileSize.width, height: tileSize.height))
                    tembok.fillColor = UIColor.green
                    tembok.alpha = 0
                    
                    if mantap.name == "Water_Grid_Center" {
                        tembok.position = CGPoint(x: 150.0 + x, y: y - 5.0 + 50.0)
                        tembok.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width, height: 30))
                    } else {
                        tembok.position = CGPoint(x: 150.0 + x, y: y + 50.0)
                        tembok.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width, height: tileSize.height))
                    }
                    
                    tembok.physicsBody?.categoryBitMask = PhysicsCategory.wall
                    tembok.physicsBody?.collisionBitMask = PhysicsCategory.player
                    tembok.physicsBody?.contactTestBitMask = PhysicsCategory.player
                    tembok.physicsBody?.isDynamic = false
                    tembok.physicsBody?.allowsRotation = false
                    tembok.physicsBody?.allowsRotation = false
                    tembok.physicsBody?.restitution = 1
                    tembok.physicsBody?.angularDamping = 0
                    tembok.physicsBody?.linearDamping = 1
                    addChild(tembok)
                }
            }
        }
    }
    
    // _ angle: CGFloat, _ diskLocation: CGPoint, _ radiusTemp: Double
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            location = touch.location(in: self)
            diskLocation = touch.location(in: disk) // diskLocation
            knob.position = CGPoint(x: 0, y: 0)
            let _ = touch.location(in: knob) // knobLocation

            disk.position = location
            disk.alpha = 0.3
            
            self.isPressed = true
            
//            disk.position.x = camera!.position.x + (location.x - camera!.position.x)
//            disk.position.y = camera!.position.y + (location.y - camera!.position.y)
            
        }
    }
    
    
    // TOUCHESMOVED UTK JOYSTICK
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            location = touch.location(in: self)
            diskLocation = touch.location(in: disk)
            let _ = touch.location(in: knob) // knobLocation
            
            rotatePlayer(location, diskLocation, angle)
        }
    }
    
    func rotatePlayer(_ location: CGPoint, _ diskLocation: CGPoint, _ angle: CGFloat) -> Void {
        let xDiskLoc: Double = diskLocation.x
        let yDiskLoc: Double = diskLocation.y
        
        let angle: CGFloat = atan2(yDiskLoc, xDiskLoc) // solusi pertama arctan(y/x)
        let radiusTemp = sqrt(pow(xDiskLoc, 2) + pow(yDiskLoc, 2))

        if radiusTemp < diskRadius {
            knob.position = diskLocation
        } else {
            knob.position = CGPoint(x: diskRadius * cos(angle), y: diskRadius * sin(angle))
          // code joystick pertama kali :  disk.position = CGPoint(x: location.x - diskRadius * cos(angle), y: location.y - diskRadius * sin(angle))
        }
        
//        disk.position.x = camera!.position.x + (location.x - camera!.position.x)
//        disk.position.y = camera!.position.y + (location.y - camera!.position.y)
        
        player.position.x += diskLocation.x * 0.015
        player.position.y += diskLocation.y * 0.015
        
        beforeLastDragGesture = lastDragGesture
        
        switch angle {
        // >>> UP
        case (Double.pi / 4) ..< (3 * Double.pi / 4):
            player.texture = SKTexture(imageNamed: "player_up")
            lastDragGesture = "up"

        // >>> LEFT
        case (3 * Double.pi / 4) ... Double.pi:
            player.texture = SKTexture(imageNamed: "player_left")
            lastDragGesture = "left"
        case (-1 * Double.pi) ... (-3 * Double.pi / 4):
            player.texture = SKTexture(imageNamed: "player_left")
            lastDragGesture = "left"

        // >>> DOWN
        case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
            player.texture = SKTexture(imageNamed: "player_down")
            lastDragGesture = "down"

        // >>> RIGHT
        case (-1 * Double.pi / 4) ... 0 :
            player.texture = SKTexture(imageNamed: "player_right")
            lastDragGesture = "right"
        case 0 ..< (Double.pi / 4):
            player.texture = SKTexture(imageNamed: "player_right")
            lastDragGesture = "right"

        default:
            lastDragGesture = ""
        }
        
//        print("b: \(beforeLastDragGesture) | l: \(lastDragGesture)")
        
        if beforeLastDragGesture == lastDragGesture {
            var textures: [SKTexture] = []
            for i in 0..<2 {
                textures.append(SKTexture(imageNamed: "player_\(beforeLastDragGesture)_animation\(i)"))
            }
            playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

            startPlayerAnimation()
        } else {
            stopPlayerAnimation()
            
            var textures: [SKTexture] = []
            for i in 0..<2 {
                textures.append(SKTexture(imageNamed: "player_\(lastDragGesture)_animation\(i)"))
            }
            playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

            startPlayerAnimation()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isPressed = false
        stopPlayerAnimation()
        disk.alpha = 0
        disk.position = CGPoint(x: camera!.position.x, y: camera!.position.y - 250)
        knob.position = CGPoint(x: 0, y: 0)
        
        diskLocation = .zero
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
}
