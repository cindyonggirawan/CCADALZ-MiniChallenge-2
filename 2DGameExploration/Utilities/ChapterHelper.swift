//
//  ChapterHelper.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation
class ChapterHelper {
    
    var activeChapter: Chapter?
    
    var chapterList: [Chapter] = []
    
    init() {
        addChapter(chapterNo: 1, chapterName: "Chapter I", levels: generateLevels(), lastUnlockedLevel: 1, isUnlocked: true, sceneName: "ChapterScene1")
        activeChapter = chapterList[0]
    }
    
    //MANAGE CHAPTER
    func addChapter(chapterNo: Int, chapterName: String, levels: [Level], lastUnlockedLevel:Int, isUnlocked: Bool, sceneName:String) {
        chapterList.append(
            Chapter(chapterNo: chapterNo,
                    chapterName: chapterName,
                    levels: levels,
                    lastUnlockedLevel: lastUnlockedLevel,
                    isUnlocked: isUnlocked, sceneName: sceneName)
        )
    }
    
    
    //MANAGE LEVEL
    func getLevel(level: Int) -> Level{
        return activeChapter!.levels[level-1]
    }
    
    func getLastLevel() -> Level {
        return activeChapter!.levels.last!
    }
    
    func addLevel(levelNo:Int, title: String, isUnlocked:Bool, tileName: String,  sceneName:String, lockedTileName: String, unlockedTileName: String, unlockedBridgeName:String) -> Level {
        return Level(levelNo: levelNo, titleName: title, isUnlocked: isUnlocked, tileName: tileName, sceneName: sceneName, lockedTileName: lockedTileName, unlockedTileName: unlockedTileName, unlockedBridgeName: unlockedBridgeName)
    }
    
    func unlockNewLevel() {
        chapterList[activeChapter!.chapterNo - 1].levels[activeChapter!.lastUnlockedLevel].isUnlocked = true
        activeChapter!.lastUnlockedLevel += 1
    }
    
    
    private func generateLevels() -> [Level] {
        var levels: [Level] = []
        
        levels.append(
            addLevel(levelNo: 1,
                     title: "New Voices",
                     isUnlocked: true,
                     tileName: "chapterTileLevel1",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel1",
                     unlockedTileName: "1-chapterTileLevel1",
                     unlockedBridgeName: "1-chapterBridge1")
        )
        levels.append(
            addLevel(levelNo: 2,
                     title: "Chapter 2 Title",
                     isUnlocked: false,
                     tileName: "chapterTileLevel2",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel2",
                     unlockedTileName: "1-chapterTileLevel2",
                     unlockedBridgeName: "1-chapterBridge2")
        )
        levels.append(
            addLevel(levelNo: 3,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel3",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel3",
                     unlockedTileName: "1-chapterTileLeve3",
                     unlockedBridgeName: "1-chapterBridge3")
        )
        levels.append(
            addLevel(levelNo: 4,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel4",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel4",
                     unlockedTileName: "1-chapterTileLeve4",
                     unlockedBridgeName: "1-chapterBridge4")
        )
        levels.append(
            addLevel(levelNo: 5,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel5",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel5",
                     unlockedTileName: "1-chapterTileLeve5",
                     unlockedBridgeName: "1-chapterBridge5")
        )
        levels.append(
            addLevel(levelNo: 6,
                     title: "Coming Soon",
                     isUnlocked: false,
                     tileName: "chapterTileLevel6",
                     sceneName: "", lockedTileName: "1-chapterTileLockedLevel6",
                     unlockedTileName: "1-chapterTileLeve6",
                     unlockedBridgeName: "1-chapterBridge6")
        )
        
        return levels
    }
}
