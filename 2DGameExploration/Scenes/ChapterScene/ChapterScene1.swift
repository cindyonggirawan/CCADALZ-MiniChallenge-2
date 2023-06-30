//
//  ChapterScene1.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 28/06/23.
//

import SpriteKit

class ChapterScene1: SKScene {
 
    var player: SKSpriteNode!
    var chapterLevelTiles:[SKSpriteNode] = []
    var chapterName: SKLabelNode!
    var levelName: SKLabelNode!
    
    var blinkingStars: SKSpriteNode!
    var blinkingStarsTexture: [SKTexture] = []
    var blinkingStarsAnimation: SKAction!
    var blinkingStarsAnimationSeq: [SKAction] = []
    
    //Temporary var
    var chapterTile = SKSpriteNode()
    var chapterBridge = SKSpriteNode()
    var texture = ""
    var idx = 0
    
    override func didMove(to view: SKView) {
        //set up blinking stars animation
        blinkingStars = childNode(withName: "blinkingStars") as? SKSpriteNode
        
        let fadeDuration = 2.0

        for idx in 1...4 {
            blinkingStarsTexture.append(SKTexture(imageNamed: "blinkingStars\(idx)"))
            let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
            var setTextureAction: SKAction!
            if idx != 4 {
                setTextureAction = SKAction.setTexture(blinkingStarsTexture[idx-1])
            } else {
                setTextureAction = SKAction.setTexture(blinkingStarsTexture[1])
            }
            let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
            
            
            blinkingStarsAnimationSeq.append(SKAction.sequence([fadeOutAction, setTextureAction, fadeInAction]))
        }
        blinkingStarsTexture.append(blinkingStarsTexture[1])
        blinkingStarsAnimation = SKAction.repeatForever(SKAction.sequence(blinkingStarsAnimationSeq))
        blinkingStars.run(SKAction.repeatForever(blinkingStarsAnimation))

        //set up chapter title
        chapterName = childNode(withName: "chapterName") as? SKLabelNode
        chapterName.text = GameData.shared.chapterHelper.currChapter.chapterName
        
        //set up level title
        levelName = childNode(withName: "levelName") as? SKLabelNode
        levelName.text = "\" \(GameData.shared.chapterHelper.currLevel.titleName) \""
        
        //set up player
        player = childNode(withName: "player") as? SKSpriteNode

        //set up level tiles
        idx = 0
        
        //set up level tiles
        for child in children {
            if child.name!.hasPrefix("chapterTile")  {
                if let child = childNode(withName: "\(child.name ?? "noName")") as? SKSpriteNode {
                    chapterLevelTiles.append(child)
                }
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        //unlock new level animation after winning the game
        if GameData.shared.chapterHelper.unlockNewLevelStatus {
            unlockNewLevel()
        }
    }
    
    override func willMove(from view: SKView) {
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        self.run(fadeOutAction)
        self.removeAllChildren()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        idx = 0
        for tile in chapterLevelTiles {
//            print("\(idx)")
//            print(GameData.shared.chapterHelper.currLevels[idx].tileName)
//            print(GameData.shared.chapterHelper.currLevels[idx].isUnlocked)

            if tile.contains(location) {
                GameData.shared.chapterHelper.currLevel = GameData.shared.chapterHelper.currLevels[idx]
                if GameData.shared.chapterHelper.currLevels[idx].isUnlocked {
                    levelName.text = "\" \(GameData.shared.chapterHelper.currLevels[idx].titleName) \""
                    
                    // brute if, karna level lain blm ada game scene-nya
                    if idx == 0 {
                        moveToNextChapterByDisapearingAndPlay(player: player, location: tile.position)
                    } else {
                        moveToNextChapterByDisapearing(player: player, location: tile.position)
                    }
                }
               
                break
            }
            idx += 1
        }
        
    }
    
    func setLabelText(node: SKLabelNode, text:String) {
        node.text = "\" \(text) \""
    }
    func setTileTexture(node: SKSpriteNode, texture: String) {
        node.texture = SKTexture(imageNamed: texture)
    }
    func setBridgeTexture(node: SKSpriteNode, status: Bool) {
        node.isHidden = !status
    }
    
    func unlockNewLevel() {
        GameData.shared.chapterHelper.unlockNewLevel()

        let lastUnlockedLevel = GameData.shared.chapterHelper.currlastUnlockedLevel
        let texture = GameData.shared.chapterHelper.currChapter.levels[lastUnlockedLevel].unlockedTileName
        
        chapterTile = (childNode(withName: "\(GameData.shared.chapterHelper.currChapter.levels[lastUnlockedLevel].tileName)") as! SKSpriteNode)
        
        chapterBridge = (childNode(withName: "\(GameData.shared.chapterHelper.currChapter.levels[lastUnlockedLevel].bridgeName)") as! SKSpriteNode)
        
        setTileTexture(node: chapterTile, texture: texture)
        setBridgeTexture(node: chapterBridge, status: true)
        
        moveToNextChapterByWalking(location: chapterTile.position)
    }
       
    // move to level that unlocked for the 1st time only
    func moveToNextChapterByWalking(location: CGPoint) {
        let targetPosition = CGPoint(x:location.x, y: location.y + 44)
        let actionDuration = 1.5
        let moveAction = SKAction.move(to: targetPosition, duration: actionDuration)

        player.run(moveAction)
    }
    
    // move to another unlocked level
    func moveToNextChapterByDisapearing(player: SKSpriteNode, location: CGPoint) {
        let targetPosition = CGPoint(x:location.x, y: location.y + 44)
        let actionDuration = 0.1
        let fadeDuration = 0.3

        let moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
        let fadeDisappearAction = SKAction.fadeAlpha(to: 0, duration: fadeDuration)
        let fadeShowAction = SKAction.fadeAlpha(to: 1, duration: fadeDuration)

        let sequence = SKAction.sequence([fadeDisappearAction, moveAction, fadeShowAction])
        GameData.shared.audioHelper.playTeleportSound()
        player.run(sequence)
    }
    
    // move to another unlocked level
    func moveToNextChapterByDisapearingAndPlay(player: SKSpriteNode, location: CGPoint) {
        let targetPosition = CGPoint(x:location.x, y: location.y + 44)
        let actionDuration = 0.1
        let fadeDuration = 0.3

        let moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
        let fadeDisappearAction = SKAction.fadeAlpha(to: 0, duration: fadeDuration)
        let fadeShowAction = SKAction.fadeAlpha(to: 1, duration: fadeDuration)

        let sequence = SKAction.sequence([fadeDisappearAction, moveAction, fadeShowAction])
        GameData.shared.audioHelper.playTeleportSound()

        player.run(sequence, completion: { [self] in
            startGame()
        })
    }
    
    func startGame() {
        GameData.shared.audioHelper.playTeleportSound()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startTheGame"), object: nil)
    }
}
