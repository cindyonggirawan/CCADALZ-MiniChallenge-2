//
//  PopUpSettingsViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 26/06/23.
//

import UIKit
import AVFAudio

class PopUpSettingsViewController: UIViewController {

 
    var isOnColorBlindMode = false
    
    var audioPlayers: [AVAudioPlayer] = []

    @IBOutlet weak var musicToggleBtn: UIButton!
    @IBOutlet weak var soundToggleBtn: UIButton!
    @IBOutlet weak var colorBlindeModeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black.withAlphaComponent(0.7)
        setToggleIcon(button: musicToggleBtn, currState: GameData.shared.audioHelper.isMusicOn)
        setToggleIcon(button: soundToggleBtn, currState: GameData.shared.audioHelper.isSoundOn)
        setToggleIcon(button: colorBlindeModeBtn, currState: isOnColorBlindMode)

    }
    
    @IBAction func exitSettingsBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func musicToggleBtnClicked(_ sender: UIButton) {
        changeSettingState(button: sender, currState: GameData.shared.audioHelper.isMusicOn)
        GameData.shared.audioHelper.changeMusicState()
    }
    

    @IBAction func soundToggleBtnClicked(_ sender: UIButton) {
        changeSettingState(button: sender, currState: GameData.shared.audioHelper.isSoundOn)
        GameData.shared.audioHelper.changeSoundState()

    }
    
    @IBAction func isOnColorBlindModeBtnClicked(_ sender: UIButton) {
        changeSettingState(button: sender, currState: isOnColorBlindMode)
        
        if(isOnColorBlindMode){
            isOnColorBlindMode = false
        } else {
            isOnColorBlindMode = true
        }
    }
    
    private func changeSettingState(button: UIButton, currState : Bool){
        if(currState){
            setToggleIcon(button: button, currState: false)
        } else {
            setToggleIcon(button: button, currState: true)
        }
    }
    
    func setToggleIcon(button: UIButton, currState: Bool){
        if(currState){
            button.setImage(UIImage(named: "iconToggleOn"), for: .normal)
        } else {
            button.setImage(UIImage(named: "iconToggleOff"), for: .normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
