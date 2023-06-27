//
//  Layer2.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 24/06/23.
//

import Foundation
import SpriteKit
// "Attemped to add a SKNode which already has a parent: <SKSpriteNode> name:'hidden member' texture:[<SKTexture> 'member0_down' (300 x 435)] position:{-45, 8} scale:{1.00, 1.00} size:{100, 145} anchor:{0.5, 0.5} rotation:0.00"    0x000060000321ca50
class Layer2: SKScene {
    var cameraNode = SKCameraNode()
    var hiddenMembers: [SKSpriteNode] = []
    var foundMembersLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        GameData.shared.setupJoystick(self)
        GameData.shared.setupPlayer(self)
        GameData.shared.setupPortal(self)
        GameData.shared.setupTile(self)
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
        foundMembersLabel.text = GameData.shared.foundMembersLabel.text
        foundMembersLabel.fontColor = SKColor.lightGray
        foundMembersLabel.fontSize = 20
        foundMembersLabel.zPosition = 999
        foundMembersLabel.horizontalAlignmentMode = .left
        foundMembersLabel.verticalAlignmentMode = .bottom
        foundMembersLabel.position = GameData.shared.foundMembersLabel.position
        
        addChild(foundMembersLabel)
    }
    
    func updateFoundMembersLabel() {
        foundMembersLabel.text = GameData.shared.foundMembersLabel.text
        foundMembersLabel.position.x = camera!.position.x
        foundMembersLabel.position.y = camera!.position.y + 250.0
    }
    
    override func update(_ currentTime: TimeInterval) {
//        GameData.shared.moveFoundMembers(self, hiddenMembers: hiddenMembers)
        GameData.shared.moveFoundMembers(self)
        updateFoundMembersLabel()

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
//        GameData.shared.checkCollisions(self, hiddenMembers: hiddenMembers)
        GameData.shared.checkCollisions(self)
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
    
    func spawnHiddenMembers(_ scene: SKScene) {
        let i = 2
//        var hiddenMembers = GameData.shared.hiddenMembers
        
        GameData.shared.hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
        GameData.shared.hiddenMembers[i].name = "hidden member"
        GameData.shared.hiddenMembers[i].zPosition = CGFloat(i + 10)
        GameData.shared.hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        GameData.shared.hiddenMembers[i].position = CGPoint(x: -165, y: 116)
        GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: 56, height: 27),
            center: CGPoint(x: 0, y: -36)
        )

        GameData.shared.hiddenMembers[i].physicsBody?.isDynamic = true
        GameData.shared.hiddenMembers[i].physicsBody?.allowsRotation = false
        GameData.shared.hiddenMembers[i].physicsBody?.categoryBitMask = PhysicsCategory.hiddenMember
        GameData.shared.hiddenMembers[i].physicsBody?.contactTestBitMask = PhysicsCategory.wall
        GameData.shared.hiddenMembers[i].physicsBody?.collisionBitMask = PhysicsCategory.wall

        scene.addChild(GameData.shared.hiddenMembers[i])
        }

}
