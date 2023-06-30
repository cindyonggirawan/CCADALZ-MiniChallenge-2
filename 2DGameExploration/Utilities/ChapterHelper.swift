//
//  ChapterHelper.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation
class ChapterHelper {
    var chapterList: [Chapter] = []
    var levelHelper = LevelHelper()

    var currChapter = Chapter()
    var currLevels : [Level] = []
    var currLevel = Level()
    var currlastUnlockedLevel = 0
    
    init() {
        currLevels = levelHelper.levelList
        currLevel = currLevels[0]
        
        addChapter(chapterNo: 0, chapterName: "Chapter I", levels: currLevels, lastUnlockedLevel: 0, isUnlocked: true, sceneName: "ChapterScene1")
        
        currChapter = chapterList[0]
    }
    
    func addChapter(chapterNo: Int, chapterName: String, levels: [Level], lastUnlockedLevel:Int, isUnlocked: Bool, sceneName:String) {
        chapterList.append(
            Chapter(chapterNo: chapterNo,
                    chapterName: chapterName,
                    levels: levels,
                    lastUnlockedLevel: lastUnlockedLevel,
                    isUnlocked: isUnlocked, sceneName: sceneName)
        )
    }
    
    func changeCurrLevel() {
        
    }
    
    func unlockNewLevel() {
        if !currChapter.levels.last!.isUnlocked {
            currlastUnlockedLevel += 1
            currChapter.lastUnlockedLevel = currlastUnlockedLevel
            currChapter.levels[currChapter.lastUnlockedLevel].isUnlocked = true
            
            currLevels = chapterList[currChapter.chapterNo].levels
            currLevel = currChapter.levels.last!
            
            //update list value for current chapter
            chapterList[currChapter.chapterNo] = currChapter
            
           
        }
           
    }
}
