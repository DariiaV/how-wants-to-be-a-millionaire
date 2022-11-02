//
//  QuestionListVC.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Veronica Rudiuk on 2.11.22.
//

import UIKit

class QuestionListVC: UIViewController {
    @IBOutlet weak var firstQuestion: UIButton!
    @IBOutlet weak var secondQuestion: UIButton!
    @IBOutlet weak var thirdQuestion: UIButton!
    @IBOutlet weak var fourthQuestion: UIButton!
    @IBOutlet weak var fifthQuestion: UIButton!
    @IBOutlet weak var sixthQuestion: UIButton!
    @IBOutlet weak var seventhQuestion: UIButton!
    @IBOutlet weak var eighthQuestion: UIButton!
    @IBOutlet weak var ninthQuestion: UIButton!
    @IBOutlet weak var tenthQuestion: UIButton!
    @IBOutlet weak var eleventhQuestion: UIButton!
    @IBOutlet weak var twelfthQuestion: UIButton!
    @IBOutlet weak var thirteenthQuestion: UIButton!
    @IBOutlet weak var fourteenthQuestion: UIButton!
    @IBOutlet weak var fifteenthQuestion: UIButton!

    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    
    
    private var millionaireBrain = MillionaireBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let slice = collectionOfButtons?.dropFirst()
        for button in slice ?? [] {
            button.isEnabled = false
        }
        
//        for subview in view.subviews where subview.tag == 1 {
//                 let button = subview as! UIButton
//                button.isEnabled = true
//            }
        
        

       
    }

    @IBAction func questionButton(_ sender: UIButton) {
        
        let questionsScreenViewController = QuestionsScreenViewController(nibName: "QuestionsScreenViewController", bundle: nil)
        show(questionsScreenViewController, sender: nil)
    }
    
    
   

}
