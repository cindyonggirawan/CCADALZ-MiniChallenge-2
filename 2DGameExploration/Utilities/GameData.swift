//
//  GameData.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 22/06/23.
//

import Foundation
import SpriteKit
import AVFoundation

class GameData {
    /*
     game data to be pass variable between layer (Game Scene) inside level
     */
    static let shared = GameData()
    
    // gameplay
    var numberOfFoundMembers: Int = 0
    var foundStatusOfFoundMembers: [Bool] = [false, false, false]
    var indexOrderOfFoundMembers: [Int] = []
    var isEnded: Bool = false
//    var isFinishGateOpenned
    
    // audio
    var audioHelper = AudioHelper()
    var audioPlayers: [AVAudioPlayer] = [] //kalo bisa dipindah ke arr di audio helper, ada kusiapin arr namanya "gamePlayMusicPlayer"
    
//    let teleportSound: SKAction = SKAction.playSoundFileNamed("teleport.mp3", waitForCompletion: false)
    let foundSound: SKAction = SKAction.playSoundFileNamed("found.mp3", waitForCompletion: false)
    
    private init() { }
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max

    static let player: UInt32 = 0x1 << 1
    static let portalA: UInt32 = 0x1 << 2
    
    static let hiddenMember: UInt32 = 0x1 << 3
    
    static let wall: UInt32 = 0x1 << 4
    static let finishGate: UInt32 = 0x1 << 5
}
