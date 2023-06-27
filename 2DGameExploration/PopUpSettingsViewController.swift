//
//  PopUpSettingsViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 26/06/23.
//

import UIKit

class PopUpSettingsViewController: UIViewController {

    var isMusicOn = true
    var isSoundOn = true
    var isOnColorBlindMode = false
    
    @IBOutlet weak var musicToggleBtn: UIButton!
    @IBOutlet weak var soundToggleBtn: UIButton!
    @IBOutlet weak var colorBlindeModeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .black.withAlphaComponent(0.7)
        
//        let chaptersMenuViewController = storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController
        
//        print(chaptersMenuViewController?.chapterCaptionLbl ?? "haiya")
//        chaptersMenuViewController?.chapterTitleLbl.isHidden = true
//        chaptersMenuViewController?.chapterCaptionLbl.isHidden = true

    }
    
    @IBAction func exitSettingsBtn(_ sender: UIButton) {
//        let chaptersMenuViewController = storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController
//        chaptersMenuViewController?.chapterTitleLbl.isHidden = false
//        chaptersMenuViewController?.chapterCaptionLbl.isHidden = false
        self.dismiss(animated: true)
    }
    
    @IBAction func musicToggleBtnClicked(_ sender: UIButton) {
        isMusicOn = changeSettingState(currState: isMusicOn, button: sender)
    }
    

    @IBAction func soundToggleBtnClicked(_ sender: UIButton) {
        isSoundOn = changeSettingState(currState: isSoundOn, button: sender)
    }
    
    @IBAction func isOnColorBlindModeBtnClicked(_ sender: UIButton) {
        isOnColorBlindMode = changeSettingState(currState: isOnColorBlindMode, button: sender)
    }
    
    private func changeSettingState(currState : Bool, button: UIButton) -> Bool {
        if(currState){
            button.setImage(UIImage(named: "iconToggleOff"), for: .normal)
            return false
        } else {
            button.setImage(UIImage(named: "iconToggleOn"), for: .normal)
            return true
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
