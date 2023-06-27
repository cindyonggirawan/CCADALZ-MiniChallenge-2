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
    
    private var buttonEffectPlayer = AVAudioPlayer()
    
    private var gameBackgroundMusicPlayer = AVAudioPlayer()
    private var gamePlayMusicPlayer: [AVAudioPlayer] = []
    
    let soundEffectsFileNames = ["activeButton.mp3", "bgm.mp3", "found.mp3", "teleport.mp3"]
    
    let gameMusicFileNames = ["level1_bgm.mp3", "level1_voice1.mp3", "level1_voice2.mp3", "level1_voice3.mp3", "level1_voice4.mp3"]
    
    //MUSIC SETTINGS
    func changeMusicState(){
        if isMusicOn {
            stopBgMusic()
        } else {
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
    
    //BG Music
    func playBgMusic(){
        isMusicOn = true
        playSound(fileName: soundEffectsFileNames[1], playerType: 1)
    }
    func stopBgMusic(){
        isMusicOn = false
        stopSound(player: gameBackgroundMusicPlayer)
    }
    
    //Game Music
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
