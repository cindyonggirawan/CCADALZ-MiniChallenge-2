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
    
    var layerTile: SKTileMapNode!
    var particle: SKEmitterNode!
    
    var foundMembersLabel: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        GameData.shared.setupJoystick(self)
        GameData.shared.setupPlayer(self)
        GameData.shared.setupPortalLevel1(self)
        GameData.shared.setupTile(self)
        GameData.shared.playerPosition = []
        generatefoundMembersLabel()
        
        spawnHiddenMembers(self)
        
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
        
//        for i in 0...1 {
            GameData.shared.hiddenMembers.append(SKSpriteNode(imageNamed: "member\(0)_down"))
            GameData.shared.hiddenMembers[0].name = "hidden member"
            GameData.shared.hiddenMembers[0].zPosition = CGFloat(10)
            GameData.shared.hiddenMembers[0].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            GameData.shared.hiddenMembers[0].position = CGPoint(x: -165, y: -20)
            GameData.shared.hiddenMembers[0].physicsBody = SKPhysicsBody(
                rectangleOf: CGSize(width: 56, height: 26),
                center: CGPoint(x: -1, y: -35)
            )

            GameData.shared.hiddenMembers[0].physicsBody?.isDynamic = true
            GameData.shared.hiddenMembers[0].physicsBody?.affectedByGravity = false
            GameData.shared.hiddenMembers[0].physicsBody?.allowsRotation = false
            GameData.shared.hiddenMembers[0].physicsBody?.categoryBitMask = PhysicsCategory.hiddenMember
            GameData.shared.hiddenMembers[0].physicsBody?.contactTestBitMask = PhysicsCategory.wall
            GameData.shared.hiddenMembers[0].physicsBody?.collisionBitMask = PhysicsCategory.wall

            scene.addChild(GameData.shared.hiddenMembers[0])
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
            GameData.shared.rotatePlayer(
                self,
                GameData.shared.location,
                GameData.shared.diskLocation,
                GameData.shared.angle
            )
            
//            disk.position.x = CGFloat(disk.position.x + diskLocation.x * 0.015)
//            disk.position.y = CGFloat(disk.position.y + diskLocation.y * 0.015)
            
            GameData.shared.disk.position = CGPoint(x: camera!.position.x, y: camera!.position.y - 250)
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

