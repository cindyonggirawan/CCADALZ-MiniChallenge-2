//
//  MenuViewController.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 23/06/23.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var startMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let mainMenuAssets = ["iconMenu1.svg", "iconMenu2.svg", "iconMenu3.svg"]
    
    @IBAction func startMenuBtnClicked (_ sender: UIButton) {
        UIView.setAnimationsEnabled(true)

        UIView.animate(withDuration: 1, delay: 1) { [self] in
            startMenuBtn.setImage(UIImage(named: self.mainMenuAssets[2]), for: .normal)
            
            if let chaptersMenuViewController = storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController {

                chaptersMenuViewController.modalTransitionStyle = .crossDissolve
                chaptersMenuViewController.modalPresentationStyle = .fullScreen
                self.present(chaptersMenuViewController, animated: true, completion: nil)
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
