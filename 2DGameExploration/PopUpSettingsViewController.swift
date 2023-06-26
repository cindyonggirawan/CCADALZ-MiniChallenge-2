//
//  PopUpSettingsViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 26/06/23.
//

import UIKit

class PopUpSettingsViewController: UIViewController {

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
//
//        chaptersMenuViewController?.chapterTitleLbl.isHidden = false
//        chaptersMenuViewController?.chapterCaptionLbl.isHidden = false
        self.dismiss(animated: true)
    }
    
    @IBAction func musicToggleBtnClicked(_ sender: UIButton) {
        
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
