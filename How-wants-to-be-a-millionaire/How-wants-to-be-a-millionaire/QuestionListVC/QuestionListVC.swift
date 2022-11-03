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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftConstraintForMainStackView()
        
        setupButtons()
        setupView()
    }
    
    //    меняю левый констрейнт у стеквью при повороте экрана
    override func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator){
        setLeftConstraintForMainStackView()
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func viewDidTapped(_ sender: UITapGestureRecognizer) {
        if isLastQuestion {
            print("You lose")
            // present final screen
            // получить несгораемую сумму
            //            print(millionaireBrain.getFireproofCash())
            
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
        
        if let button = collectionOfButtons?[currentQuestion] {
            button.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
        }
    }
    
    @IBAction func questionButton(_ sender: UIButton) {
    }
    
    //        делаю активной актуальную кнопку
    func makeActualQuestionButtonActive (actualQuestionNumber: Int) {
        let activeButton = view.viewWithTag(actualQuestionNumber) as! UIButton
        activeButton.isEnabled = true
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
