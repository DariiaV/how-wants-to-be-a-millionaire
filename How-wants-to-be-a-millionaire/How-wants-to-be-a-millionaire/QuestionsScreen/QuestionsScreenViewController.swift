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
    
    @IBOutlet weak var progressView: UIProgressView!
    
    private lazy var lockView = UIView()
    
    private var millionaireBrain = MillionaireBrain()
    private var valueSecond:Float = 30
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockView.backgroundColor = .clear
        setupButtons()
        setupImages()
        updateView()
    }
    
    
    @IBAction func getCashButton(_ sender: UIButton) {
        // открыть экран и получить деньги
    }
    
    @objc private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        if sender.view?.tag == 1 {
            sender.view?.alpha = 0
            showAlert()
        } else if sender.view?.tag == 2 {
            let removeButtons = millionaireBrain.fiftyFifty()
            hideButton(tag: removeButtons.remove1)
            hideButton(tag: removeButtons.remove2)
            sender.view?.alpha = 0
        }
    }
    
    @objc private func buttonDidTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            return
        }
        
        lockScreenFromTap(true)
        timer?.invalidate()
        
        sender.view?.backgroundColor = UIColor(named: "ButtonChoose")
        let actualAnswer = millionaireBrain.checkAnswer(tag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if actualAnswer.0 {
                sender.view?.backgroundColor = UIColor.green
            } else {
                self.highlightedCorrectButton(tag: actualAnswer.1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.millionaireBrain.nextQuestion()
                self.updateView()
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
            timer?.invalidate()
            print("You lose")
            // present final screen
            // получить несгораемую сумму
            //            print(millionaireBrain.getFireproofCash())
            return
        } else if millionaireBrain.playerMistakeCount() <= 1 {
            makeAMistakeImageView.alpha = 0
        }
        
        startCountdown()
        lockScreenFromTap(false)
        
        updateHeaderView()
        updateButtonsText()
        setButtonsDefaultColor()
        showButtons()
    }
    
    private func updateHeaderView() {
        questionTextLabel.text = millionaireBrain.getQuestionText()
        questionNumberLabel.text = millionaireBrain.getQuestionNumberText()
        cashLabel.text = millionaireBrain.getCashText()
    }
    
    private func updateButtonsText() {
        buttonALabel.text = millionaireBrain.getAnswerText(0)
        buttonBLabel.text = millionaireBrain.getAnswerText(1)
        buttonCLabel.text = millionaireBrain.getAnswerText(2)
        buttonDLabel.text = millionaireBrain.getAnswerText(3)
    }
    
    private func setButtonsDefaultColor() {
        buttonAView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonBView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonCView.backgroundColor = UIColor(named: "ButtonDefault")
        buttonDView.backgroundColor = UIColor(named: "ButtonDefault")
    }
    
    private func showButtons() {
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
    
    private func startCountdown() {
        let maxSeconds:Float = 30
        valueSecond = 30
        progressView.progress = valueSecond / maxSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.valueSecond == 0 {
                self.timer?.invalidate()
                // проигрыш
            }
            self.valueSecond -= 1
            self.progressView.progress = self.valueSecond / maxSeconds
        })
    }
    
}


