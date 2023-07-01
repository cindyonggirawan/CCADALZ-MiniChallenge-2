//
//  PopUpMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 26/06/23.
//

import UIKit

class PopUpMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
    
    @IBAction func resumeBtnClicked(_ sender: Any) {
        //Play sound effect
        GameData.shared.audioHelper.playActiveButton()
        
        self.dismiss(animated: true)
    }
    
    @IBAction func exitBtnClicked(_ sender: Any) {
        //Play sound effect
        GameData.shared.audioHelper.playActiveButton()
        
        if let chaptersMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController {

            chaptersMenuViewController.modalTransitionStyle = .crossDissolve
            chaptersMenuViewController.modalPresentationStyle = .fullScreen
        
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                    GameData.shared.audioHelper.stopAllAudioTracks()
                    UIApplication.shared.keyWindow?.rootViewController = chaptersMenuViewController
                }
            }
            
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
