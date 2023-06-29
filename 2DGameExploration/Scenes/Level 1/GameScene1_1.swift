//
//  Layer2.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 24/06/23.
//

import Foundation
import SpriteKit

class GameScene1_1: SKScene {
    var player: SKSpriteNode!
    var playerAnimation: SKAction!
    
    var didContactWall: Bool = false
    
    var cameraNode = SKCameraNode()
    var hiddenMembers: [SKSpriteNode] = []
    var foundMembers: [SKSpriteNode] = []
    var memberAnimation: SKAction!
    var membersAnimation: [SKAction] = []
    
    var layerTile: SKTileMapNode!
    var particle: SKEmitterNode!
    
    var foundMembersLabel: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        GameData.shared.setupJoystick(self)
        GameData.shared.setupPlayer(self, playerSpawnPosition: CGPoint(x: -795, y: 10))
        GameData.shared.setupPortalLevel1(self)
        GameData.shared.setupTile(self)
        GameData.shared.playerPosition = []
        generatefoundMembersLabel()
        
        spawnHiddenMembers(self)
        
        // animasi player
        var textures: [SKTexture] = []
        for i in 0..<2 {
            textures.append(SKTexture(imageNamed: "player_down_animation\(i)"))
        }
        playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)

//        spawnHiddenMembers()

        // animasi member
        for i in 0..<3 {
            textures = []
            for j in 0..<2 {
                textures.append(SKTexture(imageNamed: "member\(i)_down_animation\(j)"))
            }
            GameData.shared.memberAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
//            membersAnimation.append(memberAnimation)
        }

        
        // CAMERA
        camera = cameraNode
        cameraNode.position = CGPoint(x: GameData.shared.screenWidth / 2, y: GameData.shared.screenHeight / 2)
        
//        camera?.position.x = player.position.x
//        camera?.position.y = player.position.y
        
        // AUDIO
//        let audioFileNames = ["level1_bgm.mp3", "level1_voice1.mp3", "level1_voice2.mp3", "level1_voice3.mp3", "level1_voice4.mp3"]
//        for fileName in audioFileNames {
//            if let audioPlayer = loadAudioPlayer(fileName: fileName) {
//                GameData.shared.audioPlayers.append(audioPlayer)
//            }
//        }
//
//        playAllAudioTracks()
        
    }
    
    func generatefoundMembersLabel() {
        foundMembersLabel.name = "foundMembersLabel"
        foundMembersLabel.text = "Members Found: 0"
        foundMembersLabel.fontColor = SKColor.lightGray
        foundMembersLabel.fontSize = 20
        foundMembersLabel.zPosition = 999
        foundMembersLabel.horizontalAlignmentMode = .left
        foundMembersLabel.verticalAlignmentMode = .bottom
        foundMembersLabel.position = CGPoint.zero
        
        addChild(foundMembersLabel)
    }
    
    func spawnHiddenMembers(_ scene: SKScene) {
//        var GameData.shared.hiddenMembers = GameData.shared.hiddenMembers
        
        let i = 0
        
        if !GameData.shared.foundStatusOfFoundMembers[0]{
            GameData.shared.hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
            GameData.shared.hiddenMembers[i].name = "hidden member"
            GameData.shared.hiddenMembers[i].zPosition = CGFloat(i + 10)
            GameData.shared.hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            GameData.shared.hiddenMembers[0].position = CGPoint(x: -165, y: -20)
            GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
                rectangleOf: CGSize(width: 56, height: 26),
                center: CGPoint(x: -1, y: -35)
            )
        
//        if i == 0 {
//            GameData.shared.hiddenMembers[i].position = CGPoint(x: -45, y: 8)
//            GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
//                rectangleOf: CGSize(width: 56, height: 26),
//                center: CGPoint(x: -1, y: -35)
//            )
//        }
//        else if i == 1 {
//            GameData.shared.hiddenMembers[i].position = CGPoint(x: -60, y: -234 + 200)
//            GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
//                rectangleOf: CGSize(width: 56, height: 26),
//                center: CGPoint(x: -1, y: -35)
//            )
//        }

            GameData.shared.hiddenMembers[i].physicsBody?.isDynamic = true
            GameData.shared.hiddenMembers[i].physicsBody?.affectedByGravity = false
            GameData.shared.hiddenMembers[i].physicsBody?.allowsRotation = false
            GameData.shared.hiddenMembers[i].physicsBody?.categoryBitMask = PhysicsCategory.hiddenMember
            GameData.shared.hiddenMembers[i].physicsBody?.contactTestBitMask = PhysicsCategory.wall
            GameData.shared.hiddenMembers[i].physicsBody?.collisionBitMask = PhysicsCategory.wall

            scene.addChild(GameData.shared.hiddenMembers[i])
        }
            
//        }
    }
    
    override func update(_ currentTime: TimeInterval) {
//        print("JUMLAH MEMBER:", GameData.shared.foundMembersLabel)
//        GameData.shared.moveFoundMembers(self, hiddenMembers: hiddenMembers)
        GameData.shared.moveFoundMembers(self)
        GameData.shared.updateFoundMembersLabel(camera!)

        camera?.position.x = GameData.shared.player.position.x
        camera?.position.y = GameData.shared.player.position.y

        if GameData.shared.isPressed {
//            GameData.shared.disk.position.x = CGFloat(GameData.shared.disk.position.x + GameData.shared.diskLocation.x * (GameData.shared.playerScaler))
//            GameData.shared.disk.position.y = CGFloat(GameData.shared.disk.position.y + GameData.shared.diskLocation.y * (GameData.shared.playerScaler))

            GameData.shared.rotatePlayer(
                self,
                GameData.shared.location,
                GameData.shared.diskLocation,
                GameData.shared.angle
            )
            
            GameData.shared.moveFoundMembers(self)
            
//            GameData.shared.disk.position = CGPoint(
//                x: GameData.shared.location.x,
//                y: GameData.shared.location.y
//            )
            
//            GameData.shared.location.x
        }
        
        GameData.shared.stopPlayerAnimation()

        enumerateChildNodes(withName: "found member") { node, stop in
            if node.hasActions() {
                let member = node as! SKSpriteNode
                var index = 0

                if self.hiddenMembers.count != 0 {
                    for i in 0..<3 {
                        if member == self.hiddenMembers[i] {
                            index = i
                            break
                        }
                    }                    
                }

                GameData.shared.stopMemberAnimation(member: member, index: index)
            }
        }

        // AUDIO
//        if GameData.shared.isEnded == false {
//            let duration = GameData.shared.audioPlayers.first!.duration
//            let delay = duration + 1
//            run(SKAction.sequence([
//                SKAction.wait(forDuration: delay),
//                SKAction.run {
//                    playAllAudioTracks()
//                }
//            ]))
//        }
        
    }

    override func didEvaluateActions() {
        GameData.shared.checkCollisions(self, foundMembersLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        GameData.shared.joystickBegan(self, touch)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        GameData.shared.joystickMoved(self, touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameData.shared.joystickEnded(self)
    }

    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        shape.strokeColor = SKColor.red
        shape.lineWidth = 4.0
        addChild(shape)
    }
        
    

}

