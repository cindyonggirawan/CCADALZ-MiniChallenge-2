//
//  Chapter.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation
struct Chapter {
    var chapterNo: Int = 0
    var chapterName: String = ""
    var levels: [Level] = []
    var lastUnlockedLevel: Int = 0
    var isUnlocked: Bool = false
    var sceneName: String = ""
}
