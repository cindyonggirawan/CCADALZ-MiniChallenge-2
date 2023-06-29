//
//  Level.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation

struct Level {
    var levelNo: Int
    var titleName: String
    var isUnlocked: Bool

    var tileName: String
    var sceneName: String
    
    // for image textures
    var lockedTileName: String
    var unlockedTileName: String
    var unlockedBridgeName: String
}
