//
//  PopUpMenuViewController.swift
//  2DGameExploration
//
//  Created by Celine Margaretha on 26/06/23.
//

import UIKit

class PopUpMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black.withAlphaComponent(0.6)
    }
    
    @IBAction func resumeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
