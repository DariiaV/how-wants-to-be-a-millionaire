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
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var currentQuestion = 0
    var state = GameState.nextQuestion
    var fireproofCash = 0
    var cash = 0
    
    weak var delegate: QuestionListVCDelegate?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftConstraintForMainStackView()
        moveScrollViewToActiveButton()
        
        makeButtonsOff()
        checkIsLastQuestion()
        setupView()
        
    }
    
    //    меняю левый констрейнт у стеквью при повороте экрана
    override func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator){
        setLeftConstraintForMainStackView()
        moveScrollViewToActiveButton()
    }
    
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func viewDidTapped(_ sender: UITapGestureRecognizer) {
        switch state {
        case .nextQuestion:
            navigationController?.popViewController(animated: true)
            delegate?.viewClosed()
        default:
            let finalVC = FinalVC()
            finalVC.state = state
            finalVC.winnedMoney = state == .getMoney ? fireproofCash : cash
            navigationController?.pushViewController(finalVC, animated: true)
        }
      
    }
    
    private func makeButtonsOff() {
        for button in collectionOfButtons ?? [] {
            button.isEnabled = false
        }
    }
    
    private func checkIsLastQuestion(){
        if state == .lose {
            let previousQuestionButton = view.viewWithTag(currentQuestion + 1) as! UIButton
            previousQuestionButton.setImage(UIImage(named: "RedButtonBackground"), for: .normal)
        } else {
            //            если не проиграл, то подсвечивается и становится активной следующая кнопка
            makeButtonTransition()
        }
    }
    
    //        визуализация перехода к следующей кнопке
    private func makeButtonTransition() {
        let previousQuestionButton = view.viewWithTag(currentQuestion + 1) as! UIButton
        previousQuestionButton.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
        if currentQuestion < 14 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [self] in
                
                if currentQuestion == 4 || currentQuestion == 9 {
                    previousQuestionButton.setImage(UIImage(named: "BlueButtonBackground"), for: .normal)
                } else {
                    previousQuestionButton.setImage(UIImage(named: "PurpleButtonBackground"), for: .normal)
                }
                
                let nextQuestionButton = view.viewWithTag(currentQuestion + 2) as! UIButton
                nextQuestionButton.setImage(UIImage(named: "GreenButtonBackground"), for: .normal)
            }
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
    
    //    прокручиваю скролл вью вниз при открытии экрана если актуальный вопрос меньше 9-ого (когда экран в горизонтальном положении)
    func moveScrollViewToActiveButton() {
        if currentQuestion < 6 {
            let topOffset = CGPoint(x: 0, y: 400)
            mainScrollView.setContentOffset(topOffset, animated: false)
        } else if currentQuestion < 9 {
            let topOffset = CGPoint(x: 0, y: 150)
            mainScrollView.setContentOffset(topOffset, animated: false)
        }
    }
}


