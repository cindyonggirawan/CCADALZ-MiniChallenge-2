//
//  LevelHelper.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation
class LevelHelper {
    var levelList: [Level] = []
    
    init() {
        levelList = generateLevels()
    }
    
    func addLevel(levelNo:Int, title: String, isUnlocked:Bool, tileName: String, bridgeName: String, sceneName:String, lockedTileName: String, unlockedTileName: String, unlockedBridgeName:String) -> Level {
        return Level(levelNo: levelNo, titleName: title, isUnlocked: isUnlocked, tileName: tileName, bridgeName: bridgeName, sceneName: sceneName, lockedTileName: lockedTileName, unlockedTileName: unlockedTileName, unlockedBridgeName: unlockedBridgeName)
    }
    

    
    private func generateLevels() -> [Level] {
        var levels: [Level] = []
        
        levels.append(
            addLevel(levelNo: 1,
                     title: "New Voices",
                     isUnlocked: true,
                     tileName: "chapterTileLevel1", bridgeName: "",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel1",
                     unlockedTileName: "1-chapterTileLevel1",
                     unlockedBridgeName: "1-chapterBridge1")
        )
        levels.append(
            addLevel(levelNo: 2,
                     title: "Chapter 2 Title",
                     isUnlocked: false,
                     tileName: "chapterTileLevel2", bridgeName: "chapterBridge2",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel2",
                     unlockedTileName: "1-chapterTileLevel2",
                     unlockedBridgeName: "1-chapterBridge2")
        )
        levels.append(
            addLevel(levelNo: 3,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel3", bridgeName: "chapterBridge3",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel3",
                     unlockedTileName: "1-chapterTileLevel3",
                     unlockedBridgeName: "1-chapterBridge3")
        )
        levels.append(
            addLevel(levelNo: 4,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel4", bridgeName: "chapterBridge4",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel4",
                     unlockedTileName: "1-chapterTileLevel4",
                     unlockedBridgeName: "1-chapterBridge4")
        )
        levels.append(
            addLevel(levelNo: 5,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel5", bridgeName: "chapterBridge5",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel5",
                     unlockedTileName: "1-chapterTileLevel5",
                     unlockedBridgeName: "1-chapterBridge5")
        )
        levels.append(
            addLevel(levelNo: 6,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel6", bridgeName: "chapterBridge6",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel6",
                     unlockedTileName: "1-chapterTileLevel6",
                     unlockedBridgeName: "1-chapterBridge6")
        )
        
        return levels
    }
}
