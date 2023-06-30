//
//  ChaptersMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 25/06/23.
//

import UIKit
import SpriteKit

class ChaptersMenuViewController: UIViewController {
    
    @IBOutlet weak var settingsBtn: UIButton!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
//    var currChapter = ChapterHelper.shared.getActiveChapter()
    
//    override func loadView() {
//        self.view = SKView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        self.view.backgroundColor = .clear
//        
//        loadScene()
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(startGameplay), name: NSNotification.Name(rawValue: "startTheGame"), object: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = SKView()
        skView.frame = view.bounds
        skView.backgroundColor = .white
        skView.showsFPS = true
        view.addSubview(skView)

        let scene = SKScene(fileNamed: "ChapterScene1")!
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        view.addSubview(settingsBtn)

        NotificationCenter.default.addObserver(self, selector: #selector(startGameplay), name: NSNotification.Name(rawValue: "startTheGame"), object: nil)
    }
    
    @objc
    func startGameplay(){
        if let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {
            
            //Edit transition +  presentation style (spy full screen)
            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
            
            //Pindah/panggil gameViewController
            self.present(gameViewController, animated: true, completion: nil)
        }
    
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
    
//    func loadScene() {
//        if let view = self.view as! SKView? {
//            // Load the SKScene from '.sks' file
//            if let scene = SKScene(fileNamed: "ChapterScene1") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                scene.backgroundColor = .clear
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//        }
//    }
    
    
    @IBAction func settingsBtnClicked(_ sender: Any) {
        
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
