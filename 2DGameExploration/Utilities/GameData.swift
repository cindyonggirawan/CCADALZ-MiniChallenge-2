//
//  GameData.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 22/06/23.
//

import Foundation
import SpriteKit

class GameData {
    /*
     game data to be pass variable between layer (Game Scene) inside level
     */
    static let shared = GameData()
    
    // gameplay
    var numberOfFoundMembers: Int = 0
    var foundStatusOfFoundMembers: [Bool] = [false, false, false]
    var indexOrderOfFoundMembers: [Int] = []
    
    private init() { }
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max

    static let player: UInt32 = UInt32(pow(2.0, 1))
    static let portalA: UInt32 = UInt32(pow(2.0, 2))
    
    static let hiddenMember: UInt32 = UInt32(pow(2.0, 3)) // COBA TAMBAHIN LAYER DI GAMESCENE NYA,
                                                        // TERUS KASIH COLLISION BITMASK
}
