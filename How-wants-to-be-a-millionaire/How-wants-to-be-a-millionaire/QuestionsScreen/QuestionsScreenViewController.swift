//
//  QuestionsScreenViewController.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Дария Григорьева on 31.10.2022.
//

import UIKit

class QuestionsScreenViewController: UIViewController {
    
    @IBOutlet weak var buttonAView: UIView!
    @IBOutlet weak var buttonBView: UIView!
    @IBOutlet weak var buttonCView: UIView!
    @IBOutlet weak var buttonDView: UIView!
    
    @IBOutlet weak var buttonALabel: UILabel!
    @IBOutlet weak var buttonBLabel: UILabel!
    @IBOutlet weak var buttonCLabel: UILabel!
    @IBOutlet weak var buttonDLabel: UILabel!
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    @IBOutlet weak var makeAMistakeImageView: UIImageView!
    @IBOutlet weak var askTheAudienceImageView: UIImageView!
    @IBOutlet weak var fiftyFiftyImageView: UIImageView!
    
    private lazy var lockView = UIView()
    
    private var millionaireBrain = MillionaireBrain()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockView.backgroundColor = .clear
        setupButtons()
        setupImages()
        updateView()
    }
    
    @objc private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        if sender.view?.tag == 1 {
            sender.view?.alpha = 0
            showAlert()
        } else if sender.view?.tag == 2 {
            let removeValues = millionaireBrain.fiftyFifty()
            hideButton(tag: removeValues.remove1)
            hideButton(tag: removeValues.remove2)
            sender.view?.alpha = 0
        }
    }
    
    @objc private func buttonDidTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            return
        }
        
        sender.view?.backgroundColor = UIColor(named: "ButtonChoose")
        
        let actualAnswer = millionaireBrain.checkAnswer(tag)
        
        lockScreenFromTap(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if actualAnswer.0 {
                
                sender.view?.backgroundColor = UIColor.green
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.millionaireBrain.nextQuestion()
                self.updateView()
                }
            } else {
                self.highlightedCorrectButton(tag: actualAnswer.1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.millionaireBrain.nextQuestion()
                self.updateView()
                }
            }
        }
    }
    
    private func highlightedCorrectButton(tag: Int) {
        switch tag {
        case 0:
            buttonAView.backgroundColor = UIColor.green
        case 1:
            buttonBView.backgroundColor = UIColor.green
        case 2:
            buttonCView.backgroundColor = UIColor.green
        default:
            buttonDView.backgroundColor = UIColor.green
        }
    }
    
    private func hideButton(tag: Int) {
        switch tag {
        case 0:
            buttonAView.alpha = 0
        case 1:
            buttonBView.alpha = 0
        case 2:
            buttonCView.alpha = 0
        default:
            buttonDView.alpha = 0
        }
    }
    
    private func updateView() {
        if millionaireBrain.playerMistakeCount() <= 0 {
            print("You lose")
            // present final screen
            return
        } else if millionaireBrain.playerMistakeCount() <= 1 {
            makeAMistakeImageView.alpha = 0
        }
        
        lockScreenFromTap(false)
        questionTextLabel.text = millionaireBrain.getQuestionText()
        questionNumberLabel.text = millionaireBrain.getQuestionNumberText()
        cashLabel.text = millionaireBrain.getCashText()
        
        buttonALabel.text = millionaireBrain.getAnswerText(0)
        buttonBLabel.text = millionaireBrain.getAnswerText(1)
        buttonCLabel.text = millionaireBrain.getAnswerText(2)
        buttonDLabel.text = millionaireBrain.getAnswerText(3)
        
        
        buttonAView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonBView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonCView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonDView.backgroundColor = UIColor(named: "ButtonDefault")
        
        buttonAView.alpha = 1
        buttonBView.alpha = 1
        buttonCView.alpha = 1
        buttonDView.alpha = 1
        
    }
    
    private func lockScreenFromTap(_ isLocked: Bool) {
        if isLocked {
            view.addSubview(lockView)
            lockView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                lockView.leftAnchor.constraint(equalTo: view.leftAnchor),
                lockView.rightAnchor.constraint(equalTo: view.rightAnchor),
                lockView.topAnchor.constraint(equalTo: view.topAnchor),
                lockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ])
        } else {
            lockView.removeFromSuperview()
        }
    }
    
    private func setupButtons() {
        for button in [buttonAView, buttonBView, buttonCView, buttonDView] {
            button?.clipsToBounds = true
            button?.layer.cornerRadius = 20
        }
        
        for button in [buttonAView, buttonBView, buttonCView, buttonDView] {
            let tap = UITapGestureRecognizer(target: self, action: #selector(buttonDidTapped(_:)))
            button?.addGestureRecognizer(tap)
        }
    }
    
    private func setupImages() {
        for image in [makeAMistakeImageView, askTheAudienceImageView, fiftyFiftyImageView] {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped(_:)))
            image?.isUserInteractionEnabled = true
            image?.addGestureRecognizer(tap)
        }
    }
    
    private func showAlert() {
        let letter = millionaireBrain.getCorrectLetter()
        let randomNumber = Int.random(in: 50...80)
        let alert = UIAlertController(title: "Самый популярный ответ",
                                      message: "\(randomNumber)% проголосавли за ответ \(letter)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
}


