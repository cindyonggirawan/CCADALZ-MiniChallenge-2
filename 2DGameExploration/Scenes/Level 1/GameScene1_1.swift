//
//  Layer2.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 24/06/23.
// hello gais

import Foundation
import SpriteKit

class GameScene1_1: SKScene {
    var cameraNode = SKCameraNode()
    
    var foundMembersLabel: SKLabelNode = SKLabelNode()
    var backgroundImage: SKSpriteNode!
    var topiCountMember: SKSpriteNode!
    var playerSpawnPosition: CGPoint = CGPoint(x: -795, y: 10)
    
    var tutorLabel: SKLabelNode = SKLabelNode()
    var tutorCount = 0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        backgroundImage = scene?.childNode(withName: "bg") as? SKSpriteNode
        backgroundImage.size = self.frame.size
        backgroundImage.zPosition = -100
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        GameData.shared.setupJoystick(self)
        
        if GameData.shared.currentPortal == "portal1"{
            playerSpawnPosition = CGPoint(x: -270, y: 10)
        }else if GameData.shared.currentPortal == "portal3"{
            playerSpawnPosition = CGPoint(x: 160, y: 10)
        }else {
            playerSpawnPosition = CGPoint(x: -795, y: 10)
        }
        
        GameData.shared.setupPlayer(self, playerSpawnPosition: playerSpawnPosition)
        GameData.shared.setupPortalLevel1(self)
        GameData.shared.setupTile(self)
        GameData.shared.playerPosition = []
        generatefoundMembersLabel()
        
        spawnHiddenMembers(self)
        // TUTORIAL
        if tutorCount == 0 {
            generateTutorialLabel(text: "DRAG ANYWHERE \n        TO MOVE", x: 0, y: 200)
        }
        
        GameData.shared.initPlayerAndMemberAnimation()
        
        // CAMERA
        camera = cameraNode
        cameraNode.position = CGPoint(x: GameData.shared.screenWidth / 2, y: GameData.shared.screenHeight / 2)
        
//        camera?.position.x = player.position.x
//        camera?.position.y = player.position.y
    }
    
    func generatefoundMembersLabel() {
        foundMembersLabel.name = "foundMembersLabel"
        foundMembersLabel.text = "0/3"
        foundMembersLabel.fontColor = SKColor.white
        foundMembersLabel.fontName = "HelveticaNeue-Light"
        foundMembersLabel.fontSize = 22
        foundMembersLabel.zPosition = 999
        foundMembersLabel.horizontalAlignmentMode = .center
        foundMembersLabel.verticalAlignmentMode = .bottom
        foundMembersLabel.position = CGPoint(x: GameData.shared.player.position.x + 20, y: GameData.shared.player.position.y + 300)
        
        topiCountMember = SKSpriteNode(imageNamed: "topiCountChoir")
        topiCountMember.zPosition = 999
        topiCountMember.position = CGPoint(x: GameData.shared.player.position.x - 20, y: GameData.shared.player.position.y + 310)
        
        addChild(foundMembersLabel)
        addChild(topiCountMember)
    }
    
    func spawnHiddenMembers(_ scene: SKScene) {
//        var GameData.shared.hiddenMembers = GameData.shared.hiddenMembers
        
        let i = 0
        
        if !GameData.shared.foundStatusOfFoundMembers[i]{
            GameData.shared.hiddenMembers.append(SKSpriteNode(imageNamed: "member\(i)_down"))
            GameData.shared.hiddenMembers[i].name = "hidden member"
            GameData.shared.hiddenMembers[i].zPosition = CGFloat(i + 10)
            GameData.shared.hiddenMembers[i].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            GameData.shared.hiddenMembers[i].position = CGPoint(x: -165, y: -20)
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
//        GameData.shared.moveFoundMembers(self)
        GameData.shared.updateFoundMembersLabel(camera!)

        camera?.position.x = GameData.shared.player.position.x
        camera?.position.y = GameData.shared.player.position.y
        backgroundImage.position.x = GameData.shared.player.position.x
        backgroundImage.position.y = GameData.shared.player.position.y
        foundMembersLabel.position = CGPoint(x: GameData.shared.player.position.x + 20, y: GameData.shared.player.position.y + 300)
        topiCountMember.position = CGPoint(x: GameData.shared.player.position.x - 20, y: GameData.shared.player.position.y + 310)
        
        // TUTORIAL
        updateTutorialLabel(x: 0, y: 200)
        if GameData.shared.player.position.x >= -350.0 && tutorCount == 0 {
            tutorCount = 1
            deleteTutorialLabel()
            generateTutorialLabel(text: "TAKE YOUR FRIEND \n           WITH YOU", x: 0, y: 200)
            updateTutorialLabel(x: 0, y: 300)
            
        }
        if GameData.shared.numberOfFoundMembers >= 0 && tutorCount > 0 {
            tutorCount = 2
            deleteTutorialLabel()
            generateTutorialLabel(text: "EXPLORE AND FIND \n          THE EXIT", x: 0, y: 200)
        }

        GameData.shared.updateJoystickAndPlayer(self)
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
