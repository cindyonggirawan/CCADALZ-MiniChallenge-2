//
//  ChaptersMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 25/06/23.
//

import UIKit
import SpriteKit

class ChaptersMenuViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var currChapter = GameData.shared.chapterHelper.activeChapter
    
    override func loadView() {
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.view.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadScene()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Play music
        if !GameData.shared.audioHelper.isMusicOn {
            GameData.shared.audioHelper.playBgMusic()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //Stop BG music supaya suaranya ga nabrak sama sound gameplay
        GameData.shared.audioHelper.stopBgMusic()
    }
    
    func loadScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from '.sks' file
            if let scene = SKScene(fileNamed: "\(currChapter!.sceneName)") {
                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
                scene.backgroundColor = .clear
                
                // Present the scene
                view.presentScene(scene)
            }
            
//            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.addSubview(menuBtn)
//            view.showsPhysics = true
//            moveToNextChapter()
        }
    }
    
   
//    func moveToNextChapter() {
//        var targetPosition = CGPoint(x: 85.391, y: 209)
//        var actionDuration = 0.3
//        var moveAction = SKAction.move(to: targetPosition, duration: actionDuration)
////        moveAction = SKAction.move(to: targetPosition + offset[0], duration: actionDuration)
//    }
//
    func playBtnClicked() {
        if let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            
            //Edit transition +  presentation style (spy full screen)
            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
            
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
