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
    var audioPlayers: [AVAudioPlayer] = []
    
    // JOYSTEAK 21
    var disk: SKSpriteNode
    var knob: SKSpriteNode
    var diskRadius: CGFloat {
        CGFloat(disk.size.width / 2.0)
    }
    
    var location: CGPoint = .zero
    var diskLocation: CGPoint = .zero
    var angle: CGFloat = 0.0
    
    var isPressed: Bool = false
    var isMoved: Bool = false
    
    // PLAYER
    var player: SKSpriteNode
//    let playerScaler: Double = 0.035
    let playerScaler: Double = 0.010
    var playerAnimation: SKAction!
    
    // CHOIR
    var lastDragGesture: String = "down"
    var beforeLastDragGesture: String = "down"
    var foundMembers: [SKSpriteNode] = []
    let foundMembersLabel: SKLabelNode
    var hiddenMembers: [SKSpriteNode] = []
    var memberAnimation: SKAction!
    var membersAnimation: [SKAction] = []
    
    var didContactWall: Bool = false
    
    // PORTAL LEVEL 1 AJA               -daniel
    var portal1: SKSpriteNode?
    var portal2: SKSpriteNode?
    var portal3: SKSpriteNode?
    var finishGate: SKSpriteNode?
    var currentPortal: String
    
    // TILEMAP
    var layerTile: SKTileMapNode
    
    // PARTICLE NYANYI
    var particle: SKEmitterNode!
    
    
    private init() {
        self.disk = SKSpriteNode()
        self.knob = SKSpriteNode()
        self.player = SKSpriteNode()
        self.foundMembersLabel = SKLabelNode()
        self.layerTile = SKTileMapNode()
        self.currentPortal = "noPortal"
        
        self.portal1 = SKSpriteNode()
        self.portal2 = SKSpriteNode()
        self.portal3 = SKSpriteNode()
    }
    
    func resetGameData(){
        numberOfFoundMembers = 0
        foundStatusOfFoundMembers = [false, false, false]
        indexOrderOfFoundMembers = []
        isEnded = false
        playerPosition = []
        currentPortal = "noPortal"
        foundMembers = []
        hiddenMembers = []
        
        location = .zero
        diskLocation  = .zero
        angle = 0.0
        
        isPressed = false
        isMoved = false
    }
    
    func setupJoystick(_ scene: SKScene) {
        disk = scene.childNode(withName: "disk") as! SKSpriteNode
        knob = disk.childNode(withName: "knob") as! SKSpriteNode
        
        disk.alpha = 0 // balikin ke 0
    }
    
    func setupPlayer(_ scene: SKScene, playerSpawnPosition: CGPoint) {
//        player = scene.childNode(withName: "player") as! SKSpriteNode
        
        player = SKSpriteNode(imageNamed: "player_down")
//        player.texture = SKTexture(imageNamed: "player_down")
        
        player.name = "player"
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = playerSpawnPosition
        player.zPosition = 100
             
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
        
        GameData.shared.playerPosition = []
        
        for foundMember in foundMembers {
            foundMember.removeFromParent()
            foundMember.position = player.position
            scene.addChild(foundMember)
        }
        scene.addChild(player)
    }
    
    func setupPortalLevel1(_ scene: SKScene) {
        portal1 = scene.childNode(withName: "portal1") as? SKSpriteNode
        portal2 = scene.childNode(withName: "portal2") as? SKSpriteNode
        portal3 = scene.childNode(withName: "portal3") as? SKSpriteNode
        finishGate = scene.childNode(withName: "finishGate") as? SKSpriteNode
        
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
        
        if let finishGate {
            finishGate.physicsBody = SKPhysicsBody(rectangleOf: finishGate.size)
            finishGate.physicsBody?.isDynamic = false
            finishGate.physicsBody?.categoryBitMask = PhysicsCategory.finishGate
            finishGate.physicsBody?.contactTestBitMask = PhysicsCategory.player
            finishGate.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
    }
    
    func joystickBegan(_ scene: SKScene, _ touch: UITouch) {
        location = touch.location(in: scene)
        diskLocation = touch.location(in: disk)
        
//        disk.position = CGPoint(x: scene.camera!.position.x, y: scene.camera!.position.y)
        disk.position = location
        knob.position = .zero
        
        disk.alpha = 0.5

        self.isPressed = true
    }
    
    func joystickMoved(_ scene: SKScene, _ touch: UITouch) {
        self.isMoved = true
        
        location = touch.location(in: scene)
        diskLocation = touch.location(in: disk)

        rotatePlayer(scene, location, diskLocation, angle)
        moveFoundMembers(scene)
        
        if playerPosition.count == 60 {
            playerPosition.removeFirst()
        }
        playerPosition.append(CGPoint(x: player.position.x, y: player.position.y))
//        print(playerPosition.count)
    }
    
    func updateFoundMembersLabel(_ camera: SKCameraNode) {
        foundMembersLabel.position.x = (camera.position.x)
        foundMembersLabel.position.y = (camera.position.y + 250.0)
    }
    
    func rotatePlayer(_ scene: SKScene, _ location: CGPoint, _ diskLocation: CGPoint, _ angle: CGFloat) -> Void {
//        player = scene.childNode(withName: "player") as! SKSpriteNode
        
        let xDiskLoc: Double = diskLocation.x
        let yDiskLoc: Double = diskLocation.y

        let angle: CGFloat = atan2(yDiskLoc, xDiskLoc) // solusi pertama arctan(y/x)
        let radiusTemp = sqrt(pow(xDiskLoc, 2) + pow(yDiskLoc, 2))

        if radiusTemp < diskRadius {
            knob.position = diskLocation
        } else {
//            knob.position = CGPoint(x: diskRadius * cos(angle), y: diskRadius * sin(angle))
            // code joystick pertama kali
//             disk.position = CGPoint(x: location.x - diskRadius * cos(angle), y: location.y - diskRadius * sin(angle))
            // manusia silver
            knob.position = diskLocation
            disk.position = CGPoint(x: location.x - diskRadius * cos(angle), y: location.y - diskRadius * sin(angle))
        }

//        disk.position.x = camera!.position.x + (location.x - camera!.position.x)
//        disk.position.y = camera!.position.y + (location.y - camera!.position.y)

        beforeLastDragGesture = lastDragGesture

        player.position.x += scaleJoystickOutput(diskLocation.x)
        player.position.y += scaleJoystickOutput(diskLocation.y)

        switch angle {
        // >>> UP
        case (Double.pi / 4) ..< (3 * Double.pi / 4):
//            player.texture = SKTexture(imageNamed: "player_up")
            lastDragGesture = "up"

        // >>> LEFT
        case (3 * Double.pi / 4) ... Double.pi:
//            player.texture = SKTexture(imageNamed: "player_left")
            lastDragGesture = "left"
        case (-1 * Double.pi) ... (-3 * Double.pi / 4):
//            player.texture = SKTexture(imageNamed: "player_left")
            lastDragGesture = "left"

        // >>> DOWN
        case (-3 * Double.pi / 4) ... (-1 * Double.pi / 4):
//            player.texture = SKTexture(imageNamed: "player_down")
            lastDragGesture = "down"

        // >>> RIGHT
        case (-1 * Double.pi / 4) ... 0 :
//            player.texture = SKTexture(imageNamed: "player_right")
            lastDragGesture = "right"
        case 0 ..< (Double.pi / 4):
//            player.texture = SKTexture(imageNamed: "player_right")
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
    
    func joystickEnded(_ scene: SKScene) {
        disk.alpha = 0 // balikin ke 0
        disk.position = CGPoint(x: scene.camera!.position.x, y: scene.camera!.position.y - 250)
        knob.position = .zero

        diskLocation = .zero
        
        self.stopPlayerAnimation()
        
        scene.enumerateChildNodes(withName: "found member") { node, stop in
            if node.hasActions() {
                let member = node as! SKSpriteNode
                var index = 0
                
                for i in 0..<3 {
                    if member == self.hiddenMembers[i] {
                        index = i
                        break
                    }
                }
                
                self.stopMemberAnimation(member: member, index: index)
            }
        }
        
        self.isPressed = false
        self.isMoved = false
        diskLocation = .zero
    }
    
    
    func updateJoystickAndPlayer(_ scene: SKScene) {
        if (self.isPressed && self.isMoved) {
            rotatePlayer(scene, location, diskLocation, angle)
            disk.position.x += scaleJoystickOutput(diskLocation.x)
            disk.position.y += scaleJoystickOutput(diskLocation.y)
            
            moveFoundMembers(scene)
        }
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
//        var foundMembers: [SKSpriteNode] = []
        scene.enumerateChildNodes(withName: "hidden member") { node, _ in
            let member = node as! SKSpriteNode
            if CGRectIntersectsRect(CGRectInset(member.frame, 30, 30), CGRectInset(self.player.frame, 30, 30)) {
                self.foundMembers.append(member)
            }
            
//            print("x")
        }
//        print("b")

        for member in self.foundMembers {
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
//                numberOfFoundMembers += 1 biar ga jadi sekabupaten
                
                if foundStatusOfFoundMembers[i] == false {
                    foundStatusOfFoundMembers[i] = true
                    indexOrderOfFoundMembers.append(i)
                    addParticleToMember(index: i)
                    GameData.shared.audioHelper.playFoundSound()
                    AudioHelper.adjustVolume()
                }
            }
        }

        foundMembersLabel.text = "\(GameData.shared.foundMembers.count)/3"

//        let turnGreen = SKAction.colorize(with: SKColor.green, colorBlendFactor: 1.0, duration: 0.2)
//        member.run(turnGreen)
    }
    
//    func moveFoundMembers(_ scene: SKScene, hiddenMembers: [SKSpriteNode]) {
    func moveFoundMembers(_ scene: SKScene) {
        var targetPosition = player.position
        let actionDuration = 0.3
        var moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
//        let offset = [
//            CGPoint(x: 0, y: -tileSize.height),
//            CGPoint(x: tileSize.width, y: 0),
//            CGPoint(x: 0, y: tileSize.height),
//            CGPoint(x: -tileSize.width, y: 0)
//        ]
        
        if playerPosition.count > 40 {
            targetPosition = self.playerPosition[40]
        }
        
        scene.enumerateChildNodes(withName: "found member") { node, stop in
            let member = node as! SKSpriteNode
            
            var index = 0
            
            for i in 0..<3 {
                if member == self.hiddenMembers[i] {
                    index = i
                    break
                }
            }
            
            if self.beforeLastDragGesture == self.lastDragGesture {
                var textures: [SKTexture] = []
                for i in 0..<2 {
                    textures.append(SKTexture(imageNamed: "member\(index)_\(self.beforeLastDragGesture)_animation\(i)"))
                }
                self.memberAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

                self.startMemberAnimation(member: member, index: index)
            } else {
                self.stopMemberAnimation(member: member, index: index)

                var textures: [SKTexture] = []
                for i in 0..<2 {
                    textures.append(SKTexture(imageNamed: "member\(index)_\(self.lastDragGesture)_animation\(i)"))
                }
                self.memberAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

                self.startMemberAnimation(member: member, index: index)
            }
        }

        scene.enumerateChildNodes(withName: "found member") { node, stop in
            let member = node as! SKSpriteNode
            var index = 0

            for i in 0..<self.hiddenMembers.count {
                if member == self.hiddenMembers[i] {
//                    index = 0
                    
                    //ATUR INJEK INJEKANNYA
                    self.player.zPosition = 100
                    self.setupZPosition(choirMember: member)
                    
                    if self.playerPosition.count > 40{
                        if i == 0 {
                            targetPosition = self.playerPosition[40]
                        } else if i == 1 {
                            targetPosition = self.playerPosition[30]
                        } else {
                            targetPosition = self.playerPosition[20]
                        }
                    } else if self.playerPosition.count > 20 {
                        if i == 0 {
                            targetPosition = self.playerPosition[12]
                        } else if i == 1 {
                            targetPosition = self.playerPosition[8]
                        } else {
                            targetPosition = self.playerPosition[4]
                        }
                    }else if self.playerPosition.count > 5 {
                        if i == 0 {
                            targetPosition = self.playerPosition[3]
                        } else if i == 1 {
                            targetPosition = self.playerPosition[2]
                        } else {
                            targetPosition = self.playerPosition[1]
                        }
                    }

                    
                    break
                }
            }
            
            if self.playerPosition.count > 5 {
                moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
            } else {
                moveAction = SKAction.move(to: targetPosition, duration: 0)
            }
            
            if self.lastDragGesture == "up" {
//                    node.zRotation = CGFloat(Double.pi) / 2.0
                self.player.zPosition = 0
                if self.hiddenMembers.count == 1 {
                    self.hiddenMembers[0].zPosition = 110
                }
                
                if self.hiddenMembers.count == 2 {
                    self.hiddenMembers[0].zPosition = 110
                    self.hiddenMembers[1].zPosition = 120
                }
                
                if self.hiddenMembers.count == 3 {
                    self.hiddenMembers[0].zPosition = 110
                    self.hiddenMembers[1].zPosition = 120
                    self.hiddenMembers[2].zPosition = 130
                }
                
//                member.texture = SKTexture(imageNamed: "member\(index)_up")
//                    member.texture = SKTexture(imageNamed: "\(memberName)_up")
//                    moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
            } else if self.lastDragGesture == "left" {
//                    node.zRotation = CGFloat(Double.pi) / 1.0
                self.player.zPosition = 100.0
//                member.texture = SKTexture(imageNamed: "member\(index)_left")
//                    member.texture = SKTexture(imageNamed: "\(memberName)_left")
//                    moveAction = SKAction.move(to: targetPosition + offset[1], duration: actionDuration)
            } else if self.lastDragGesture == "down" {
                self.player.zPosition = 100.0
//                    self.hiddenMembers[0].zPosition = 30
//                    self.hiddenMembers[1].zPosition = 20
//                    self.hiddenMembers[2].zPosition = 10
                
                if self.hiddenMembers.count == 1 {
                    self.hiddenMembers[0].zPosition = 30
                }
                
                if self.hiddenMembers.count == 2 {
                    self.hiddenMembers[0].zPosition = 20
                    self.hiddenMembers[1].zPosition = 10
                }
                
                if self.hiddenMembers.count == 3 {
                    self.hiddenMembers[0].zPosition = 30
                    self.hiddenMembers[1].zPosition = 20
                    self.hiddenMembers[2].zPosition = 10
                }
                
//                    node.zRotation = CGFloat(Double.pi) / 2.0 + CGFloat(Double.pi)
//                    member.texture = SKTexture(imageNamed: "\(memberName)_down")
//                member.texture = SKTexture(imageNamed: "member\(index)_down")
//                    moveAction = SKAction.move(to: targetPosition + offset[2], duration: actionDuration)
            } else if self.lastDragGesture == "right" {
//                    node.zRotation = 0
//                    member.texture = SKTexture(imageNamed: "\(memberName)_right")
//                member.texture = SKTexture(imageNamed: "member\(index)_right")
//                    moveAction = SKAction.move(to: targetPosition + offset[3], duration: actionDuration)
            }

            node.run(moveAction)
        
            // member selanjutnya berada dibelakang member pertama
            targetPosition = node.position
        }
    }
    
    func setupZPosition(choirMember: SKSpriteNode){
        if choirMember.position.y > self.player.position.y{
            choirMember.zPosition = 90
        } else {
            choirMember.zPosition = 110
        }
    }
    
    func startPlayerAnimation() {
        if player.action(forKey: "playerAnimation") == nil {
            player.run(SKAction.repeatForever(playerAnimation),
                        withKey: "playerAnimation")
        }
    }
    
    func stopPlayerAnimation() {
        player.removeAction(forKey: "playerAnimation")
    }
    
    func addParticleToPlayer() {
        particle = SKEmitterNode(fileNamed: "Particle")
        particle.position = CGPoint(x: 0, y: player.size.height / 2)
        player.addChild(particle)
    }
    
    func startMemberAnimation(member: SKSpriteNode, index: Int) {
        if member.action(forKey: "member\(index)Animation") == nil {
            member.run(SKAction.repeatForever(memberAnimation),
                        withKey: "member\(index)Animation")
        }
    }

    func stopMemberAnimation(member: SKSpriteNode, index: Int) {
        member.removeAction(forKey: "member\(index)Animation")
    }
    
    func initPlayerAndMemberAnimation() {
        addParticleToPlayer()
        
        // animasi player
        var textures: [SKTexture] = []
        for i in 0..<2 {
            textures.append(SKTexture(imageNamed: "player_down_animation\(i)"))
        }
        playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

        // animasi member
        for i in 0..<3 {
            textures = []
            for j in 0..<2 {
                textures.append(SKTexture(imageNamed: "member\(i)_down_animation\(j)"))
            }
            memberAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        }
    }
    
    func addParticleToMember(index: Int) {
        particle = SKEmitterNode(fileNamed: "Particle")
        particle.position = CGPoint(x: 0, y: hiddenMembers[index].size.height / 2)
        hiddenMembers[index].addChild(particle)
    }

    func scaleJoystickOutput(_ value: Double) -> Double {
//        return (1 / (0.25 + pow(2, -0.7 * value))) - 2.0
        return (1 / (0.25 + pow(2, -0.2 * (value + 10)))) - 2.0
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
