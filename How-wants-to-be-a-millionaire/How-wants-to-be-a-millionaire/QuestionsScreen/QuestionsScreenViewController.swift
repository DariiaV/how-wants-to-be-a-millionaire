//
//  QuestionsScreenViewController.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Дария Григорьева on 31.10.2022.
//

import UIKit

class QuestionsScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        button.addGestureRecognizer(tap)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button in buttonsViewCollection {
            button.clipsToBounds = true
            button.layer.cornerRadius = 20
        }
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
    }
}
