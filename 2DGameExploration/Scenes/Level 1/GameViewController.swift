//
//  GameViewController.swift
//  2DGameExploration
//
//  Created by Cindy Amanda Onggirawan on 19/06/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.backgroundColor = .darkGray
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.addSubview(menuBtn)
//            view.showsPhysics = true

        }
    }
    @IBAction func menuBtnClicked(_ sender: UIButton) {
        print("sepp")
        if let popUpMenuViewController = storyboard?.instantiateViewController(withIdentifier: "PopUpMenuViewController") as? PopUpMenuViewController {

            popUpMenuViewController.modalTransitionStyle = .crossDissolve
            popUpMenuViewController.modalPresentationStyle = .overCurrentContext
            
//            performSegue(withIdentifier: "segueToPopUpMenuViewController", sender: self)
            
            self.present(popUpMenuViewController, animated: true, completion: nil)
        }
        
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
