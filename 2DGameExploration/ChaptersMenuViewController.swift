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

            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
            
//            performSegue(withIdentifier: "segueToGameViewController", sender: self)
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        if let popUpSettingsViewController = storyboard?.instantiateViewController(withIdentifier: "PopUpSettingsViewController") as? PopUpSettingsViewController {

            popUpSettingsViewController.modalTransitionStyle = .crossDissolve
            popUpSettingsViewController.modalPresentationStyle = .overCurrentContext
            
//            chapterTitleLbl.isHidden = true
//            chapterCaptionLbl.isHidden = true
            
//            performSegue(withIdentifier: "segueToPopUpMenuViewController", sender: self)
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
