//
//  Onboarding.swift
//  Lost Choir
//
//  Created by Louis Mayco Dillon Wijaya on 30/06/23.
//

import Foundation
import UIKit
import SpriteKit

//protocol TutorialLabel: SKScene {
//    func generateTutorialLabel(text: String, x: CGFloat, y: CGFloat) {
//        var tutorLabel = SKLabelNode()
//
//        tutorLabel.name = "tutorial:\(text)"
//        tutorLabel.text = "\(text)"
//        tutorLabel.fontColor = SKColor.white
//        tutorLabel.fontName = "HelveticaNeue-Light"
//        tutorLabel.fontSize = 16
//        tutorLabel.zPosition = 999
//        tutorLabel.horizontalAlignmentMode = .center
//        tutorLabel.verticalAlignmentMode = .bottom
//        tutorLabel.position = CGPoint(x: GameData.shared.player.position.x + x, y: GameData.shared.player.position.y + y)
//
//        addChild(tutorLabel)
//    }
//}

extension GameScene1_1 {
//    var tutorLabel: SKLabelNode = SKLabelNode()
    func generateTutorialLabel(text: String, x: CGFloat, y: CGFloat) {

        tutorLabel.name = "tutorial:\(text)"
        tutorLabel.text = "\(text)"
        tutorLabel.fontColor = SKColor.white
        tutorLabel.fontName = "HelveticaNeue-Light"
        tutorLabel.fontSize = 16
        tutorLabel.zPosition = 999
        tutorLabel.position = CGPoint(x: GameData.shared.player.position.x - x, y: GameData.shared.player.position.y + y)
        tutorLabel.numberOfLines = 2
        
        // Set the alignment to center
        tutorLabel.horizontalAlignmentMode = .center
        tutorLabel.verticalAlignmentMode = .center

        addChild(tutorLabel)
    }
    
    func updateTutorialLabel(x: CGFloat, y: CGFloat){
        tutorLabel.position = CGPoint(x: GameData.shared.player.position.x - x, y: GameData.shared.player.position.y + y)
    }
    
    func deleteTutorialLabel(){
        tutorLabel.removeFromParent()
    }
}
    

