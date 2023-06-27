//
//  ChaptersMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 25/06/23.
//

import UIKit

class ChaptersMenuViewController: UIViewController {


    @IBOutlet weak var chapterTitleLbl: UILabel!
    @IBOutlet weak var chapterCaptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        chapterTitleLbl.isHidden = false
//        chapterCaptionLbl.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        chapterTitleLbl.isHidden = false
//        chapterCaptionLbl.isHidden = false
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        if let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            
            //Edit transition +  presentation style (spy full screen)
            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
            
            //Stop BG music supaya suaranya ga nabrak sama sound gameplay
            GameData.shared.audioHelper.stopBgMusic()
            
            //Pindah/panggil gameViewController
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        if let popUpSettingsViewController = storyboard?.instantiateViewController(withIdentifier: "PopUpSettingsViewController") as? PopUpSettingsViewController {

            //Edit transition +  presentation style (spy full screen)
            popUpSettingsViewController.modalTransitionStyle = .crossDissolve
            popUpSettingsViewController.modalPresentationStyle = .overCurrentContext
            
            //Play sound effect
            GameData.shared.audioHelper.playActiveButton()
            
            //Pindah/panggil popUpSettingsViewController
            self.present(popUpSettingsViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func unwindSegue (sender: UIStoryboardSegue){
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
