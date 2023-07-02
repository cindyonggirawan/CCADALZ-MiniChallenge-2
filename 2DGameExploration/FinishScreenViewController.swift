//
//  FinishScreenViewController.swift
//  2DGameExploration
//
//  Created by Alfine on 27/06/23.
//

import UIKit

class FinishScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .black.withAlphaComponent(0.6)
        
    }
    
    @IBAction func nextLvlBtn(_ sender: Any) {
        if let chaptersMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController {

            chaptersMenuViewController.modalTransitionStyle = .crossDissolve
            chaptersMenuViewController.modalPresentationStyle = .fullScreen
            
            // unlock new level
            GameData.shared.chapterHelper.unlockNewLevelStatus = true
            
            GameData.shared.audioHelper.stopAllAudioTracks()
            GameData.shared.audioHelper.playActiveButton()
            
            self.present(chaptersMenuViewController, animated: true, completion: nil)
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
