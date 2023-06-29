//
//  GameData.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 22/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class GameData {
    /*
     game data to be pass variable between layer (Game Scene) inside level
     */
    static let shared = GameData()
    
    // GAMEPLAY
    var numberOfFoundMembers: Int = 0
    var foundStatusOfFoundMembers: [Bool] = [false, false, false]
    var indexOrderOfFoundMembers: [Int] = []
    var isEnded: Bool = false
    var gamefirstStarted: Bool = true
    var playerPosition: [CGPoint] = []
//    var isFinishGateOpenned
    
    // chapter
    var chapterHelper = ChapterHelper()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var tileSize = CGSize(width: 40, height: 40)

    
    // AUDIO
    var audioHelper = AudioHelper()
    let teleportSound: SKAction = SKAction.playSoundFileNamed("teleport.mp3", waitForCompletion: false)
    var audioPlayers: [AVAudioPlayer] = [] //kalo bisa dipindah ke arr di audio helper, ada kusiapin arr namanya "gamePlayMusicPlayer"
    
//    let teleportSound: SKAction = SKAction.playSoundFileNamed("teleport.mp3", waitForCompletion: false)
    let foundSound: SKAction = SKAction.playSoundFileNamed("found.mp3", waitForCompletion: false)
    
    // JOYSTEAK 21
    var location: CGPoint = .zero
    var diskLocation: CGPoint = .zero
    var angle: CGFloat = 0.0
    var isPressed: Bool = false
    var disk: SKSpriteNode
    var knob: SKSpriteNode
    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0) // CONVERT PIXEL TO POINT
    }
    
    // PLAYER
    var player: SKSpriteNode
    let playerScaler: Double = 0.015
    
    // CHOIR
    var lastDragGesture: String = ""
    var foundMembers: [SKSpriteNode] = []
    let foundMembersLabel: SKLabelNode
    var hiddenMembers: [SKSpriteNode] = []
    
    var didContactWall: Bool = false
    
    // PORTAL LEVEL 1 AJA               -daniel
    var portal1: SKSpriteNode?
    var portal2: SKSpriteNode?
    var portal3: SKSpriteNode?
    
    // PORTAL LEVEL 2 DISINI            -daniel
    // ada 9 portal kayaknya ya? -daniel
    // var portal....
    
    // TILEMAP
    var layerTile: SKTileMapNode
    
    private init() {
        self.disk = SKSpriteNode()
        self.knob = SKSpriteNode()
        self.player = SKSpriteNode()
        self.foundMembersLabel = SKLabelNode()
        self.layerTile = SKTileMapNode()
        
        self.portal1 = SKSpriteNode()
        self.portal2 = SKSpriteNode()
        self.portal3 = SKSpriteNode()
    }
    
    func setupJoystick(_ scene: SKScene) {
        disk = scene.childNode(withName: "disk") as! SKSpriteNode
        knob = disk.childNode(withName: "knob") as! SKSpriteNode
        
        disk.alpha = 0 // balikin ke 0
    }
    
    func setupPlayer(_ scene: SKScene) {
        player = scene.childNode(withName: "player") as! SKSpriteNode
//        player = SKSpriteNode(imageNamed: "player_down")
//        player.texture = SKTexture(imageNamed: "player_down")
        
        player.name = "player"
//        player.position = CGPoint(x: -795 + 80, y: -25.105)
             
        player.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: 56, height: 26),
            center: CGPoint(x: 0, y: -30)
        )
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = PhysicsCategory.portal | PhysicsCategory.wall
        player.physicsBody?.collisionBitMask = PhysicsCategory.wall
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.restitution = 0
        player.physicsBody?.angularDamping = 1
        player.physicsBody?.linearDamping = 1
        
//        scene.addChild(player)
    }
    
    func setupPortalLevel1(_ scene: SKScene) {
        portal1 = scene.childNode(withName: "portal1") as? SKSpriteNode
        portal2 = scene.childNode(withName: "portal2") as? SKSpriteNode
        portal3 = scene.childNode(withName: "portal3") as? SKSpriteNode
        
        if let portal1 {
            portal1.physicsBody = SKPhysicsBody(rectangleOf: portal1.size)
            portal1.physicsBody?.isDynamic = false
            portal1.physicsBody?.categoryBitMask = PhysicsCategory.portal
            portal1.physicsBody?.contactTestBitMask = PhysicsCategory.player
            portal1.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
        
        if let portal2 {
            portal2.physicsBody = SKPhysicsBody(rectangleOf: portal2.size)
            portal2.physicsBody?.isDynamic = false
            portal2.physicsBody?.categoryBitMask = PhysicsCategory.portal
            portal2.physicsBody?.contactTestBitMask = PhysicsCategory.player
            portal2.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
        
        if let portal3 {
            portal3.physicsBody = SKPhysicsBody(rectangleOf: portal3.size)
            portal3.physicsBody?.isDynamic = false
            portal3.physicsBody?.categoryBitMask = PhysicsCategory.portal
            portal3.physicsBody?.contactTestBitMask = PhysicsCategory.player
            portal3.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
    }
    
    func joystickBegan(_ scene: SKScene, _ touch: UITouch) {
        location = touch.location(in: scene)
        diskLocation = touch.location(in: disk) // diskLocation
        knob.position = CGPoint(x: 0, y: 0)
        
        disk.position = location
        disk.alpha = 0.3

        self.isPressed = true
    }
    
    func joystickMoved(_ scene: SKScene, _ touch: UITouch) {
        location = touch.location(in: scene)
        diskLocation = touch.location(in: disk)

        rotatePlayer(scene, location, diskLocation, angle)
        
        if playerPosition.count == 60 {
            playerPosition.removeFirst()
        }
        playerPosition.append(CGPoint(x: player.position.x, y: player.position.y))
    }
    
    func updateFoundMembersLabel(_ camera: SKCameraNode) {
        foundMembersLabel.position.x = (camera.position.x)
        foundMembersLabel.position.y = (camera.position.y + 250.0)
    }
    
    func rotatePlayer(_ scene: SKScene, _ location: CGPoint, _ diskLocation: CGPoint, _ angle: CGFloat) -> Void {
        player = scene.childNode(withName: "player") as! SKSpriteNode
        
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

        player.position.x += diskLocation.x * playerScaler
        player.position.y += diskLocation.y * playerScaler

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
    }
    
    func joystickEnded(_ scene: SKScene) {
        self.isPressed = false
        
        var disk = scene.childNode(withName: "disk") as! SKSpriteNode
        var knob = disk.childNode(withName: "knob") as! SKSpriteNode
        
        disk.alpha = 0 // balikin ke 0
        disk.position = CGPoint(x: scene.camera!.position.x, y: scene.camera!.position.y - 250)
        knob.position = CGPoint(x: 0, y: 0)

        diskLocation = .zero
    }
    
    func setupTile(_ scene: SKScene) {
        layerTile = scene.childNode(withName: "WallTilesMap") as! SKTileMapNode
        setUpMapPhysics(scene, layerTile)
        
    }
    
    func setUpMapPhysics(_ scene: SKScene,_ tileMap: SKTileMapNode) {
        let tileSize = CGSize(width: 40, height: 40)

        let halfWidth = (CGFloat(tileMap.numberOfColumns) / 2.0) * tileSize.width
        let halfHeight = (CGFloat(tileMap.numberOfRows) / 2.0) * tileSize.width

        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let mantap = tileMap.tileDefinition(atColumn: col, row: row) {
                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width) / 2
                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height) / 2


                    let tembok = SKShapeNode(rectOf: CGSize(width: tileSize.width, height: tileSize.height))
//                    tembok.fillColor = UIColor.green
                    tembok.alpha = 0

                    if mantap.name == "Water_Grid_Center" {
                        tembok.position = CGPoint(x: x, y: y - 5.0)
                        tembok.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width, height: 30))
                    } else {
                        tembok.position = CGPoint(x: x, y: y)
                        tembok.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width, height: tileSize.height))
                    }

                    tembok.physicsBody?.categoryBitMask = PhysicsCategory.wall
                    tembok.physicsBody?.collisionBitMask = PhysicsCategory.player
                    tembok.physicsBody?.contactTestBitMask = PhysicsCategory.player
                    tembok.physicsBody?.isDynamic = false
                    tembok.physicsBody?.allowsRotation = false
                    tembok.physicsBody?.restitution = 0
                    tembok.physicsBody?.angularDamping = 1
                    tembok.physicsBody?.linearDamping = 1
                    scene.addChild(tembok)
                }
            }
        }
    }
    
//    func checkCollisions(_ scene: SKScene, hiddenMembers: [SKSpriteNode]) {
    func checkCollisions(_ scene: SKScene, _ foundMembersLabel: SKLabelNode) {
        var foundMembers: [SKSpriteNode] = []
        scene.enumerateChildNodes(withName: "hidden member") { node, _ in
            let member = node as! SKSpriteNode
            if CGRectIntersectsRect(member.frame, self.player.frame) {
                foundMembers.append(member)
            }
        }

        for member in foundMembers {
//            print("a member is found")
//            findHiddenMember(member: member, hiddenMembers: hiddenMembers)
            findHiddenMember(member: member, foundMembersLabel)
        }
    }
    
//    func findHiddenMember(member: SKSpriteNode, hiddenMembers: [SKSpriteNode]) {
    func findHiddenMember(member: SKSpriteNode, _ foundMembersLabel: SKLabelNode) {
        member.name = "found member"

        for i in 0 ..< hiddenMembers.count {
            if member == hiddenMembers[i] {
                numberOfFoundMembers += 1
                foundStatusOfFoundMembers[i] = true
                indexOrderOfFoundMembers.append(i)

                AudioHelper.adjustVolume()
            }
        }

        foundMembersLabel.text = "Members Found: \(GameData.shared.numberOfFoundMembers)"

//        let turnGreen = SKAction.colorize(with: SKColor.green, colorBlendFactor: 1.0, duration: 0.2)
//        member.run(turnGreen)
    }
    
//    func moveFoundMembers(_ scene: SKScene, hiddenMembers: [SKSpriteNode]) {
    func moveFoundMembers(_ scene: SKScene) {
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
        
        if playerPosition.count > 40 {
            targetPosition = self.playerPosition[40]
        }

        scene.enumerateChildNodes(withName: "found member") { node, stop in
            if !node.hasActions() {
                let member = node as! SKSpriteNode

                for i in 0..<self.hiddenMembers.count {
                    if member == self.hiddenMembers[i] {
                        memberName = "member\(i)"
                        
                        
                        //ATUR INJEK INJEKANNYA
                        self.player.zPosition = 100
                        setupZPosition(choirMember: member)
                        if self.playerPosition.count > 40{
                            if i == 0 {
                                targetPosition = self.playerPosition[40]
                            }else if i == 1 {
                                targetPosition = self.playerPosition[30]
                            }else {
                                targetPosition = self.playerPosition[20]
                            }
                        }
                        
                        break
                    }
                }
                
                if self.playerPosition.count >= 59{
                    moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
                }
                
                
                if self.lastDragGesture == "up" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0
                    member.texture = SKTexture(imageNamed: "\(memberName)_up")
//                    moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
                } else if self.lastDragGesture == "left" {
//                    node.zRotation = CGFloat(Double.pi) / 1.0
                    member.texture = SKTexture(imageNamed: "\(memberName)_left")
//                    moveAction = SKAction.move(to: targetPosition + offset[1], duration: actionDuration)
                } else if self.lastDragGesture == "down" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
                    member.texture = SKTexture(imageNamed: "\(memberName)_down")
//                    moveAction = SKAction.move(to: targetPosition + offset[2], duration: actionDuration)
                } else if self.lastDragGesture == "right" {
//                    node.zRotation = 0
                    member.texture = SKTexture(imageNamed: "\(memberName)_right")
//                    moveAction = SKAction.move(to: targetPosition + offset[3], duration: actionDuration)
                }

                node.run(moveAction)
            }

            // member selanjutnya berada dibelakang member pertama
            targetPosition = node.position
        }
        
        func setupZPosition(choirMember: SKSpriteNode){
            if choirMember.position.y > self.player.position.y{
                choirMember.zPosition = 90
            }else{
                choirMember.zPosition = 110
            }
        }
    }
    
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max

    static let player: UInt32 = 0x1 << 1
    static let portal: UInt32 = 0x1 << 2
    
    static let hiddenMember: UInt32 = 0x1 << 3
    
    static let wall: UInt32 = 0x1 << 4
    static let finishGate: UInt32 = 0x1 << 5
}
