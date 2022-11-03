//
//  QuestionListVC.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Veronica Rudiuk on 2.11.22.
//

import UIKit

class QuestionListVC: UIViewController {
    
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    @IBOutlet weak var mainLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondLeadingConstraint: NSLayoutConstraint!
    
    var millionaireBrain = MillionaireBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //    меняю левый констрейнт у стеквью при повороте экрана
        setLeftConstraintForMainStackView()
        
        //        делаю все кнопки неактивными
        for button in collectionOfButtons ?? [] {
            button.isEnabled = false
        }
        
        //        делаю активной актуальную кнопку
        makeActualQuestionButtonActive(actualQuestionNumber: millionaireBrain.questionNumber)
        
    }
    
    //    меняю левый констрейнт у стеквью при повороте экрана
    override func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator){
        setLeftConstraintForMainStackView()
    }
    
    
    
    @IBAction func questionButton(_ sender: UIButton) {
        
        //        перехожу на страницу с вопросами
        let questionsScreenViewController = QuestionsScreenViewController(nibName: "QuestionsScreenViewController", bundle: nil)
        questionsScreenViewController.millionaireBrain = millionaireBrain
        show(questionsScreenViewController, sender: nil)
    }
    
    //        делаю активной актуальную кнопку
    func makeActualQuestionButtonActive (actualQuestionNumber: Int) {
        if actualQuestionNumber > 1 {
                        let previousQuestionButton = view.viewWithTag(actualQuestionNumber) as! UIButton
                        previousQuestionButton.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            let activeButton = self.view.viewWithTag(actualQuestionNumber + 1) as! UIButton
                            activeButton.isEnabled = true
                            previousQuestionButton.setImage(UIImage(named: "PurpleButtonBackground"), for: .normal)
                        }
                    } else {
                        let activeButton = self.view.viewWithTag(actualQuestionNumber + 1) as! UIButton
                        activeButton.isEnabled = true
                    }
//            UIView.animate(withDuration: 6, delay: 0) {
//
//                let activeButton = self.view.viewWithTag(actualQuestionNumber + 1) as! UIButton
//                activeButton.isEnabled = true
//                self.view.layoutSubviews()
//            }
            
        }
    
        
        //    меняю левый констрейнт у стеквью при повороте экрана
        func setLeftConstraintForMainStackView() {
            if UIDevice.current.orientation.isLandscape {
                mainLeadingConstraint.priority = UILayoutPriority(rawValue: 750)
                secondLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
            } else if UIDevice.current.orientation.isPortrait {
                mainLeadingConstraint.priority = UILayoutPriority(rawValue: 1000)
                secondLeadingConstraint.priority = UILayoutPriority(rawValue: 750)
            }
        }
        
        //    func switchingToTheActiveButton
        
    }
