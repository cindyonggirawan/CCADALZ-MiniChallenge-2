////
////  JoystickMovement.swift
////  2DGameExploration
////
////  Created by Daniel Bernard Sahala Simamora on 28/06/23.
////
//
//import Foundation
//import SpriteKit
//
//class JoystickMovement {
//    var disk: SKSpriteNode
//    var knob: SKSpriteNode
//    
//    init(_ disk: SKSpriteNode, _ knob: SKSpriteNode) {
//        self.disk = disk
//        self.knob = knob
//    }
//    
//    func renderJoystick(_ view: SKScene) {
//        disk = view.childNode(withName: "disk") as! SKSpriteNode
//        knob = disk.childNode(withName: "knob") as! SKSpriteNode
//        
//        disk.alpha = 1
//    }
//    
//    func resetJoystick(_ view: SKScene) {
//        self.isPressed = false
//        
//        var disk = view.childNode(withName: "disk") as! SKSpriteNode
//        var knob = disk.childNode(withName: "knob") as! SKSpriteNode
//        
//        disk.alpha = 0
//        disk.position = CGPoint(x: view.camera!.position.x, y: view.camera!.position.y - 250)
//        knob.position = CGPoint(x: 0, y: 0)
//
//        diskLocation = .zero
//    }
//}
