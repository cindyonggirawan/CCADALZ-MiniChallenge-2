//
//  ChaptersMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 25/06/23.
//

import UIKit

class ChaptersMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playBtnClicked(_ sender: Any) {
        if let gameViewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController {

            gameViewController.modalTransitionStyle = .crossDissolve
            gameViewController.modalPresentationStyle = .fullScreen
//            performSegue(withIdentifier: "segueToGameViewController", sender: self)

            self.present(gameViewController, animated: true, completion: nil)
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
