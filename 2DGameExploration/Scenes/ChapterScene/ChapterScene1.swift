//
//  ChapterScene1.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 28/06/23.
//

import UIKit
import SpriteKit

class ChapterScene1: SKScene {
    
    var player: SKSpriteNode!
    var chapterTiles:[SKSpriteNode]!
    
    var chapterTileLevel: SKSpriteNode!
    var chapterBridge: SKSpriteNode!
    
    var background: SKSpriteNode!
    var tileMapNode: SKSpriteNode!
    var chapterName: SKSpriteNode!
    var levelName: SKSpriteNode!
    
    var playerAnimation: SKAction!
    
    var playerXPos: Double = 0.0
    var playerYPos: Double = 0.0
    
    var currLevel: Int = 2
    
    override func didMove(to view: SKView) {
        //create player
        player = childNode(withName: "player") as? SKSpriteNode
        
        // Set up tiles
        for child in children {
            if child.name == "chapterTile" {
                if let child = child as? SKSpriteNode {
                    chapterTiles.append(child)
                }
            }
        }
        
        
        
      
        //        chapterTileLevel = childNode(withName: "chapterTileLevel4") as? SKSpriteNode
        //        chapterBridge = childNode(withName: "chapterBridge4") as? SKSpriteNode
        //        addChild(chapterTileLevel2)
        
        // Add tap gesture recognizer
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        //        scene?.view?.addGestureRecognizer(tapGesture)
        
        
        
        //        let texture2 = SKTexture(imageNamed: "chapterTileLevel6")
        //        let action = SKAction.setTexture(texture2, resize: true)
        
        //        chapterTileLevel2.
        //        chapterTileLevel2.run(action)
        
        //        chapterTileLevel2.touchesBegan(Set<UITouch>, with: UIEvent?)
        
        //        player.name = "player"
        //        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //        player.position = CGPoint(x: -75, y: -209)
        
        // animasi player
        //        var textures: [SKTexture] = []
        //        for i in 0..<2 {
        //            textures.append(SKTexture(imageNamed: "player_down_animation\(i)"))
        //        }
        //
        //        playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        //add child
        //        background = childNode(withName: "background") as? SKSpriteNode
        //        tileMapNode = childNode(withName: "tileMapNode") as? SKSpriteNode
        //        chapterName = childNode(withName: "chapterName") as? SKSpriteNode
        //        levelName = childNode(withName: "levelName") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        chapterTileLevel = childNode(withName: "\(GameData.shared.chapterHelper.getLevel(level: 1).tileName)") as? SKSpriteNode
        
        if chapterTileLevel.contains(location) {
            
            guard let layer1 = GameScene1_1(fileNamed: "GameScene1_1_Temp") else { return }
            let transition = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(layer1, transition: transition)
            
            
//            guard let newLayer = GameScene1_1(fileNamed: "GameScene1_1") else {
//                return
//            }
//            view?.presentScene(newLayer, transition: .crossFade(withDuration: 1))

            print("\(GameData.shared.chapterHelper.getLevel(level: 1).tileName)")
        }
        // Check if the sprite node was touched
        
//        for tile in chapterTiles {
//            if tile.contains(location) {
//                unlockNewLevel()
//            }
//        }
//        if chapterTileLevel.contains(location) {
//            // Change the texture of the sprite node to the new texture
//            //               let newTexture = SKTexture(imageNamed: "1-chapterTileLevel5")
//            //               chapterTileLevel.texture = newTexture
//            //               chapterBridge.isHidden = false
//            //
//            //               print(chapterTileLevel.name)
//            //               print("\(chapterTileLevel.position)")
//            //               moveToNextChapter(location: chapterTileLevel.position)
//        }
    }
    
    
    //    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
    //        let location = gestureRecognizer.location(in: self)
    //
    //        // Check if the sprite node was clicked
    //        if chapterTileLevel2.contains(location) {
    //            // Change the texture of the sprite node to the new texture
    //            let newTexture = SKTexture(imageNamed: "chapterTileLevel6")
    //            chapterTileLevel2.texture = newTexture
    //        }
    //    }
    
    
    func unlockNewLevel() {
        GameData.shared.chapterHelper.unlockNewLevel()
//        chapterTileLevel: SKSpriteNode!
        chapterTileLevel = childNode(withName: "\(GameData.shared.chapterHelper.getLastLevel().lockedTileName)") as? SKSpriteNode
        chapterBridge = childNode(withName: "\(GameData.shared.chapterHelper.getLastLevel().unlockedBridgeName)") as? SKSpriteNode
        
        let newTexture = SKTexture(imageNamed: "\(GameData.shared.chapterHelper.getLastLevel().unlockedTileName)")
        chapterTileLevel.texture = newTexture
        chapterBridge.isHidden = true
        moveToNextChapter(location: chapterTileLevel.position)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if currLevel == 2 {
            //            moveToNextChapter()
        }
    }
    
    func moveToNextChapter(location: CGPoint) {
        var targetPosition = CGPoint(x:location.x, y: location.y + 44)
        var actionDuration = 0.3
        
        var moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
        //        moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
        player.run(moveAction)
    }
}
