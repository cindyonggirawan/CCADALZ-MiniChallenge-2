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
    
    var unlockNewLevelStatus = false
    
    init() {
        currLevels = levelHelper.dummyLevelList
        currLevel = currLevels[0]
        
        addChapter(chapterNo: 0, chapterName: "Chapter I", levels: currLevels, lastUnlockedLevel: 0, isUnlocked: true, sceneName: "ChapterScene1")
        
        currChapter = chapterList[0]
        currlastUnlockedLevel = currChapter.lastUnlockedLevel
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
    
    
    func unlockNewLevel() {
        let lastOpenedChapter = currChapter.levels[currlastUnlockedLevel].isUnlocked
        let nextOpenedChapter = currChapter.levels[currlastUnlockedLevel+1].isUnlocked
        
        if lastOpenedChapter && (nextOpenedChapter == false) && unlockNewLevelStatus {
            currlastUnlockedLevel += 1
            currLevels[currlastUnlockedLevel].isUnlocked = true
            
            currChapter.lastUnlockedLevel = currlastUnlockedLevel
            currChapter.levels = currLevels
            
            currLevel = currLevels[currlastUnlockedLevel]
            
            //update list value for current chapter
            chapterList[currChapter.chapterNo] = currChapter
            
            unlockNewLevelStatus = false
            print("ini di chapter helper")
            print(currLevel.tileName)
            print(currLevel.isUnlocked)
        }
        
    }
}
