//
//  QuestionListVC.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Veronica Rudiuk on 2.11.22.
//

import UIKit

protocol QuestionListVCDelegate: AnyObject {
    func viewClosed()
}

class QuestionListVC: UIViewController {
    
    @IBOutlet var collectionOfButtons: [UIButton]?
    
    @IBOutlet weak var mainLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondLeadingConstraint: NSLayoutConstraint!
    
    var currentQuestion = 0
    var isLastQuestion = false
    weak var delegate: QuestionListVCDelegate?
    var activeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActiveButton()
        setLeftConstraintForMainStackView()
        
        setupButtons()
        setupView()
    }
    
    //    меняю левый констрейнт у стеквью при повороте экрана
    override func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator){
        setLeftConstraintForMainStackView()
    }
    
    private func setupActiveButton() {
        print(activeButton)
        if currentQuestion < 14 {
            activeButton = view.viewWithTag(currentQuestion + 2) as! UIButton
        }
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        
        activeButton.addGestureRecognizer(tap)
    }
    
    @objc private func viewDidTapped(_ sender: UITapGestureRecognizer) {
        if isLastQuestion {
            print("You lose")
            // present final screen
            // получить несгораемую сумму
            // print(millionaireBrain.getFireproofCash())
            
            let looseVC = LooseVC()
            navigationController?.pushViewController(looseVC, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
            delegate?.viewClosed()
        }
    }
    
    private func setupButtons() {
        for button in collectionOfButtons ?? [] {
            button.isEnabled = false
        }
        print(currentQuestion)
        
//        визуализация перехода к следующей кнопке
        let previousQuestionButton = view.viewWithTag(currentQuestion + 1) as! UIButton
        previousQuestionButton.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
            activeButton.isEnabled = true
            activeButton.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
            if currentQuestion == 4 || currentQuestion == 9 {
                previousQuestionButton.setImage(UIImage(named: "BlueButtonBackground"), for: .normal)
            } else {
                previousQuestionButton.setImage(UIImage(named: "PurpleButtonBackground"), for: .normal)
            }
            previousQuestionButton.isEnabled = false
        }
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
}

