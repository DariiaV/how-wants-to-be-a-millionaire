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
    
    //    фиксирую этот экран в портретном режиме
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    //    после закрытия этого экрана разрешаю другим экранам менять ориентацию в зависимости от положения девайса
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
}
