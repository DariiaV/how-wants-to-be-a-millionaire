//
//  MainScreen.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Владислав on 31.10.2022.
//

import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var rulesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        let q = QuestionsScreenViewController()
        navigationController?.pushViewController(q, animated: true)
    }
    
    @IBAction func gameRules(sender: AnyObject) {
        rulesButton.titleLabel?.font = UIFont(name: "Roboto Regular", size: 32)
        let rulesPage = RulesPage(nibName: "RulesPage", bundle: nil)
        show(rulesPage, sender: nil)
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
