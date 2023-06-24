//
//  Layer2.swift
//  2DGameExploration
//
//  Created by Daniel Bernard Sahala Simamora on 24/06/23.
//

import Foundation
import SpriteKit

class Layer2: SKScene {
    var oke: SKSpriteNode!
    override func didMove(to view: SKView) {
        oke = childNode(withName: "halo") as? SKSpriteNode
//        print(oke.color)
        print(oke)
    }
}
