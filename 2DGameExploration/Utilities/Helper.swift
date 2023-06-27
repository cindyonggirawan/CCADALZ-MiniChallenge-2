//
//  Helper.swift
//  2DGameExploration
//
//  Created by Cindy Amanda Onggirawan on 22/06/23.
//

import Foundation
import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= ( left: inout CGPoint, right: CGPoint) {
    left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
    
    var angle: CGFloat {
        return atan2(y, x)
    }
}

import AVFoundation

func loadAudioPlayer(fileName: String) -> AVAudioPlayer? {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
        print("Error: Audio file not found - \(fileName)")
        return nil
    }
    
    do {
        let url = URL(fileURLWithPath: filePath)
        let audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer.numberOfLoops = 0
        audioPlayer.prepareToPlay()
        return audioPlayer
    } catch {
        print("Error: Unable to load audio file - \(fileName), error: \(error)")
        return nil
    }
}

func playAllAudioTracks() {
    for (index, audioPlayer) in GameData.shared.audioPlayers.enumerated() {
        if index == 0 || index == 1 {
            audioPlayer.volume = 1.0
        } else {
            audioPlayer.volume = 0.0
            adjustVolume()
        }
        audioPlayer.play()
    }
    
}

func stopAllAudioTracks() {
    for audioPlayer in GameData.shared.audioPlayers {
        audioPlayer.stop()
    }
}

func adjustVolume() {
    print("found members = \(GameData.shared.indexOrderOfFoundMembers)")
    print("audio nodes = \(GameData.shared.audioPlayers)")
    if GameData.shared.indexOrderOfFoundMembers.count > 0 && GameData.shared.audioPlayers.count > 1 {
        for memberIndex in GameData.shared.indexOrderOfFoundMembers {
            GameData.shared.audioPlayers[memberIndex + 2].volume = 1.0
        }
        // + 1 untuk index yang start dari 0
        // + 1 untuk index pertama yang dikhususkan untuk bgm
    }
}
