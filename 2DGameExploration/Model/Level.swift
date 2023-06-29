//
//  Level.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation

struct Level {
    var levelNo: Int = 0
    var titleName: String = ""
    var isUnlocked: Bool = false

    var tileName: String = ""
    var bridgeName: String = ""
    var sceneName: String = ""
    
    // for image textures
    var lockedTileName: String = ""
    var unlockedTileName: String = ""
    var unlockedBridgeName: String = ""
}
