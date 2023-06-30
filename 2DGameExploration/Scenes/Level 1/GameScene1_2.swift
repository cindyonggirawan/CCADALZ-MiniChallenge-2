//
//  Layer2.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 24/06/23.
//

import Foundation
import SpriteKit


class GameScene1_2: SKScene {
    var cameraNode = SKCameraNode()
    
    var foundMembersLabel: SKLabelNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        GameData.shared.setupJoystick(self)
        GameData.shared.setupPlayer(self, playerSpawnPosition: CGPoint(x: 20, y: 281))
        GameData.shared.setupPortalLevel1(self)
        GameData.shared.setupTile(self)
        generatefoundMembersLabel()
        
        spawnHiddenMembers(self)
        
        GameData.shared.initPlayerAndMemberAnimation()
        
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
        foundMembersLabel.text = "0/3"
        foundMembersLabel.fontColor = SKColor.white
        foundMembersLabel.fontSize = 30
        foundMembersLabel.zPosition = 999
        foundMembersLabel.horizontalAlignmentMode = .center
        foundMembersLabel.verticalAlignmentMode = .bottom
        foundMembersLabel.position = CGPoint(x: GameData.shared.player.position.x, y: GameData.shared.player.position.y + 300)
        
        addChild(foundMembersLabel)
    }
    
    func spawnHiddenMembers(_ scene: SKScene) {
        let i = 1
        
//<<<<<<< Updated upstream
//        GameData.shared.hiddenMembers[i].position = CGPoint(x: 15, y: -2.501)

//        GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
//            rectangleOf: CGSize(width: 56, height: 27),
//            center: CGPoint(x: 0, y: -36)
//        )
//=======
        if !GameData.shared.foundStatusOfFoundMembers[i]{
            GameData.shared.hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
            GameData.shared.hiddenMembers[i].name = "hidden member"
            GameData.shared.hiddenMembers[i].zPosition = CGFloat(i + 10)
            GameData.shared.hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            GameData.shared.hiddenMembers[i].position = CGPoint(x: 20, y: 50)
            GameData.shared.hiddenMembers[i].physicsBody = SKPhysicsBody(
                rectangleOf: CGSize(width: 56, height: 27),
                center: CGPoint(x: 0, y: -36)
            )
//>>>>>>> Stashed changes

            GameData.shared.hiddenMembers[i].physicsBody?.isDynamic = true
            GameData.shared.hiddenMembers[i].physicsBody?.affectedByGravity = false
            GameData.shared.hiddenMembers[i].physicsBody?.allowsRotation = false
            GameData.shared.hiddenMembers[i].physicsBody?.categoryBitMask = PhysicsCategory.hiddenMember
            GameData.shared.hiddenMembers[i].physicsBody?.contactTestBitMask = PhysicsCategory.wall
            GameData.shared.hiddenMembers[i].physicsBody?.collisionBitMask = PhysicsCategory.wall

            scene.addChild(GameData.shared.hiddenMembers[i])
        }
            
    }
    
    override func update(_ currentTime: TimeInterval) {
//        print("JUMLAH MEMBER:", GameData.shared.foundMembersLabel)
//        GameData.shared.moveFoundMembers(self, hiddenMembers: hiddenMembers)
//        GameData.shared.moveFoundMembers(self)
        GameData.shared.updateFoundMembersLabel(camera!)

        camera?.position.x = GameData.shared.player.position.x
        camera?.position.y = GameData.shared.player.position.y
        foundMembersLabel.position = CGPoint(x: GameData.shared.player.position.x, y: GameData.shared.player.position.y + 300)

//<<<<<<< HEAD
//        if GameData.shared.isPressed {
//            GameData.shared.disk.position.x = CGFloat(GameData.shared.disk.position.x + GameData.shared.diskLocation.x * (GameData.shared.playerScaler))
//            GameData.shared.disk.position.y = CGFloat(GameData.shared.disk.position.y + GameData.shared.diskLocation.y * (GameData.shared.playerScaler))
//
//            GameData.shared.rotatePlayer(
//                self,
//                GameData.shared.location,
//                GameData.shared.diskLocation,
//                GameData.shared.angle
//            )
//
//            GameData.shared.moveFoundMembers(self)
//
////            GameData.shared.disk.position = CGPoint(
////                x: GameData.shared.location.x,
////                y: GameData.shared.location.y
//=======
        GameData.shared.updateJoystickAndPlayer(self)
        
//        if GameData.shared.isPressed {
//            print("YEAHHASDHASDB")
//            GameData.shared.disk.position.x = CGFloat(GameData.shared.disk.position.x + GameData.shared.diskLocation.x * (GameData.shared.playerScaler))
//            GameData.shared.disk.position.y = CGFloat(GameData.shared.disk.position.y + GameData.shared.diskLocation.y * (GameData.shared.playerScaler))
//
//            GameData.shared.rotatePlayer(
//                self,
//                GameData.shared.location,
//                GameData.shared.diskLocation,
//                GameData.shared.angle
//>>>>>>> cd1ba58 (fix joystick, fix player bergerak sendiri)
//            )
//
//            GameData.shared.moveFoundMembers(self)
//
////            GameData.shared.disk.position = CGPoint(
////                x: GameData.shared.location.x,
////                y: GameData.shared.location.y
////            )
//
////            GameData.shared.location.x
//        }

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
}
