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
        GameData.shared.audioHelper.playBgMusic()
    }
    
    let mainMenuAssets = ["iconMenu1.svg", "iconMenu2.svg", "iconMenu3.svg"]
    
    @IBAction func startMenuBtnClicked (_ sender: UIButton) {
        
//        let newButtonWidth: CGFloat = 60
        UIView.animate(withDuration: 0.4, //1
            delay: 0.0, //2
            usingSpringWithDamping: 0, //3
            initialSpringVelocity: 0, //4
            options: UIView.AnimationOptions.curveEaseInOut, //5
            animations: ({ //6
            sender.layer.opacity = 0.1
//            sender.setImage(UIImage(named: self.mainMenuAssets[2]), for: .normal)
//
//            sender.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth) //2
                
//                sender.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
//            sender.center = self.view.center
            
            
            //Play sound
            GameData.shared.audioHelper.playActiveButton()
        }), completion: {_ in
            if let chaptersMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController {

                chaptersMenuViewController.modalTransitionStyle = .crossDissolve
                chaptersMenuViewController.modalPresentationStyle = .fullScreen
                self.present(chaptersMenuViewController, animated: true, completion: nil)
            }
            
        })
        
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
