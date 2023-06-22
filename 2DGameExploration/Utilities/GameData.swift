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
    var numberOfMembersCollected: Int = 0
    
    private init() { }
}
