//
//  AudioHelper.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 27/06/23.
//

import AVFoundation

class AudioHelper {
    
    var isSoundOn = true
    var isMusicOn = true
    var fromOnboarding = true
    
    private var buttonEffectPlayer = AVAudioPlayer()
    
    private var gameBackgroundMusicPlayer = AVAudioPlayer()
    private var gamePlayMusicPlayer: [AVAudioPlayer] = []
    
    let soundEffectsFileNames = ["activeButton.mp3", "bgm.mp3", "found.mp3", "teleport.mp3"]
    
    let gameMusicFileNames = ["level1_bgm.mp3", "level1_voice1.mp3", "level1_voice2.mp3", "level1_voice3.mp3", "level1_voice4.mp3"]
    
    //MUSIC SETTINGS
    func changeMusicState(){
        if isMusicOn {
            isMusicOn = false
            stopBgMusic()
        } else {
            isMusicOn = true
            playBgMusic()
        }
    }
    func changeSoundState(){
        if isSoundOn {
            isSoundOn = false
        } else {
            isSoundOn = true
        }
    }
    
    //Sound Effects
    func playActiveButton(){
        if isSoundOn {
            playSound(fileName: soundEffectsFileNames[0], playerType: 0)
        }
    }
    
    func playFoundSound(){
        if isSoundOn {
            playSound(fileName: soundEffectsFileNames[2], playerType: 0)
        }
    }
    
    func playTeleportSound(){
        if isSoundOn {
            playSound(fileName: soundEffectsFileNames[3], playerType: 0)
        }
    }
    
    //BG Music
    func playBgMusic(){
//        isMusicOn = true
        playSound(fileName: soundEffectsFileNames[1], playerType: 1)
    }
    func stopBgMusic(){
//        isMusicOn = false
        stopSound(player: gameBackgroundMusicPlayer)
    }
    
    //Game Music
    func loadAudioPlayer(fileName: String) -> AVAudioPlayer? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
            print("Error: Audio file not found - \(fileName)")
            return nil
        }
        
        do {
            let url = URL(fileURLWithPath: filePath)
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            return audioPlayer
        } catch {
            print("Error: Unable to load audio file - \(fileName), error: \(error)")
            return nil
        }
    }
    
    func appendAudioPlayer() {
        if isMusicOn {
            for fileName in gameMusicFileNames {
                if let audioPlayer = loadAudioPlayer(fileName: fileName) {
                    GameData.shared.audioPlayers.append(audioPlayer)
                }
            }
        }
        print("append audio \(isMusicOn): \(GameData.shared.audioPlayers.count)")
    }

    func playAllAudioTracks() {
        if isMusicOn {
            for (index, audioPlayer) in GameData.shared.audioPlayers.enumerated() {
                if index == 0 || index == 1 {
                    audioPlayer.volume = 1.0
                } else {
                    audioPlayer.volume = 0.0
                    AudioHelper.adjustVolume()
                }
                audioPlayer.play()
            }
        }
        print("play all audio \(!GameData.shared.audioPlayers.isEmpty && isMusicOn): \(GameData.shared.audioPlayers.count)")

    }

    func stopAllAudioTracks() {
        if isMusicOn {
            for audioPlayer in GameData.shared.audioPlayers {
                audioPlayer.stop()
            }
            GameData.shared.audioPlayers.removeAll()
        }
        print("stop all audio \(!GameData.shared.audioPlayers.isEmpty && isMusicOn): \(GameData.shared.audioPlayers.count)")

    }

    static func adjustVolume() {
    //    print("found members = \(GameData.shared.indexOrderOfFoundMembers)")
    //    print("audio nodes = \(GameData.shared.audioPlayers)")
        if GameData.shared.indexOrderOfFoundMembers.count > 0 && GameData.shared.audioPlayers.count > 1 {
            for memberIndex in GameData.shared.indexOrderOfFoundMembers {
                GameData.shared.audioPlayers[memberIndex + 2].volume = 1.0
            }
            // + 1 untuk index yang start dari 0
            // + 1 untuk index pertama yang dikhususkan untuk bgm
        }
    }
    
    //PLAY AN AUDIO -> for sound effects
    private func playSound(fileName: String, playerType: Int) {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Error: Audio file not found - \(fileName)")
            return
        }
        
        switch(playerType) {
            //button effect player
            case 0:
                do {
                    try buttonEffectPlayer = AVAudioPlayer(contentsOf: filePath)
                    buttonEffectPlayer.volume = 1.0
                    buttonEffectPlayer.numberOfLoops = 0
                    buttonEffectPlayer.prepareToPlay()
                    buttonEffectPlayer.play()
                } catch {
                    print("Error: Could not create audio player")
                    return
                }
            
            //game background music player
            case 1:
                do {
                    try self.gameBackgroundMusicPlayer = AVAudioPlayer(contentsOf: filePath)
                    gameBackgroundMusicPlayer.volume = 1.0
                    gameBackgroundMusicPlayer.numberOfLoops = -1
                    gameBackgroundMusicPlayer.prepareToPlay()
                    gameBackgroundMusicPlayer.play()
                } catch {
                    print("Error: Could not create audio player")
                    return
                }
            break
            
        default:
            break
        }
    }
    
    //STOP AN AUDIO
    private func stopSound(player: AVAudioPlayer) {
        player.stop()
    }
    
}
