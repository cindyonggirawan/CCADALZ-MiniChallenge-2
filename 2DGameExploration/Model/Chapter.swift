//
//  Chapter.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 29/06/23.
//

import Foundation
struct Chapter {
    var chapterNo: Int
    var chapterName: String
    var levels: [Level]
    var lastUnlockedLevel: Int
    var isUnlocked: Bool
    var sceneName: String
}
