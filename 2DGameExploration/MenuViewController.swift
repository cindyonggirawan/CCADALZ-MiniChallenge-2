//
//  MenuViewController.swift
//  2DGameExploration
//
//  Created by Louis Mayco Dillon Wijaya on 23/06/23.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {

    @IBOutlet weak var startMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView()
        skView.frame = view.bounds
        skView.backgroundColor = .white
        skView.showsFPS = true
        view.addSubview(skView)

        let scene = SKScene(fileNamed: "OnboardingScene")!
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        view.addSubview(startMenuBtn)

        GameData.shared.audioHelper.playBgMusic()
    }
        
    @IBAction func startMenuBtnClicked (_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 0,
            initialSpringVelocity: 0,
            options: UIView.AnimationOptions.curveEaseInOut,
            animations: ({
            sender.layer.opacity = 0.1
            
            //Play sound
            GameData.shared.audioHelper.playActiveButton()
        }), completion: {_ in
                        
            if let chaptersMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChaptersMenuViewController") as? ChaptersMenuViewController {

                chaptersMenuViewController.modalTransitionStyle = .crossDissolve
                chaptersMenuViewController.modalPresentationStyle = .fullScreen
                UIApplication.shared.keyWindow?.rootViewController = chaptersMenuViewController

                self.present(chaptersMenuViewController, animated: true, completion: {
                })
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
