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
    
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var getCashOutlet: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    private lazy var lockView = UIView()
    
    private var millionaireBrain = MillionaireBrain()
    private let player = AudioManager()
    private var valueSecond: Float = 30
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lockView.backgroundColor = .clear
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupButtons()
        setupImages()
        updateView()
        
    }
    
    @IBAction func getCashButton(_ sender: UIButton) {
        // кнопка забрать деньги
        // открыть экран и получить деньги
        
        let alertController = UIAlertController(title: "Забрать деньги", message: "Вы хотите забрать несгораеммую сумму - \(millionaireBrain.getFireproofCash()) RUB?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Да", style: .default) { (action) in
            self.timer?.invalidate()
            self.player.stopPlay()
            let finalVC = FinalVC()
            finalVC.winnedMoney = self.millionaireBrain.getFireproofCash()
            finalVC.prizeBrain.printTakeMoney()
            self.navigationController?.pushViewController(finalVC, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .default) { (action) in }
        
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    @objc private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        if sender.view?.tag == 1 {
            sender.view?.alpha = 0
            showAlert()
        } else if sender.view?.tag == 2 {
            let (index1, index2) = millionaireBrain.fiftyFifty()
            hideButton(index: index1)
            hideButton(index: index2)
            sender.view?.alpha = 0
        }
    }
    
    @objc private func buttonDidTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else {
            return
        }
        
        player.stopPlay()
        player.playSound(soundName: "wait")
        lockScreenFromTap(true)
        timer?.invalidate()
        
        sender.view?.backgroundColor = UIColor(named: "ButtonChoose")
        let (answer, index) = millionaireBrain.checkAnswerAndGetCurrentIndex(tag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.player.stopPlay()
            if answer {
                self.player.playSound(soundName: "correctAnswer")
                sender.view?.backgroundColor = UIColor.green
            } else {
                self.millionaireBrain.userGetMistake()
                self.player.playSound(soundName: "wrongAnswer")
                self.highlightedCorrectButton(tag: index)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.checkUserAnswer()
            }
        }
    }
    
    private func highlightedCorrectButton(tag: Int) {
        // подсветить кнопку по индексу
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
    
    private func hideButton(index: Int) {
        switch index {
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
    
    private func checkUserAnswer() {
        if millionaireBrain.getMistakeCount() <= 0 {
            presentQuestionList(true)
            return
        } else if millionaireBrain.getMistakeCount() <= 1 {
            makeAMistakeImageView.alpha = 0
        }
        millionaireBrain.getCurrentNumber() < 14 ? presentQuestionList(false) : openWinVC()
    }
    
    
    private func updateView() {
        player.stopPlay()
        player.playSound(soundName: "SecondsCount")
        
        startCountdown()
        lockScreenFromTap(false)
        
        updateHeaderView()
        updateButtonsText()
        setButtonsDefaultColor()
        showButtons()
        
        makeGetCashButtonActiveOrNot()
    }
    
    private func presentQuestionList(_ isLastQuestion: Bool) {
        player.stopPlay()
        let questionListVC = QuestionListVC()
        questionListVC.isLastQuestion = isLastQuestion
        questionListVC.delegate = self
        questionListVC.currentQuestion = millionaireBrain.getCurrentNumber()
        navigationController?.pushViewController(questionListVC, animated: true)
    }
    
    private func openWinVC() {
        let finalVC = FinalVC()
        finalVC.winnedMoney = self.millionaireBrain.getCashNumber()
        finalVC.prizeBrain.printTotalWin()
        self.navigationController?.pushViewController(finalVC, animated: true)
    }
    
    //    self.millionaireBrain.nextQuestion()
    
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
    
    //    если у игрока есть несгораемая сумма, то кнопка "Забрать деньги" активна. Иначе она неактивна
    private func makeGetCashButtonActiveOrNot() {
        if millionaireBrain.getFireproofCash() == 0 {
            getCashOutlet.isEnabled = false
        } else {
            getCashOutlet.isEnabled = true
        }
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
            // закруглить кнопки
            button?.clipsToBounds = true
            button?.layer.cornerRadius = 20
        }
        
        for button in [buttonAView, buttonBView, buttonCView, buttonDView] {
            // добавить действие на кнопки
            let tap = UITapGestureRecognizer(target: self, action: #selector(buttonDidTapped(_:)))
            button?.addGestureRecognizer(tap)
        }
    }
    
    private func setupImages() {
        for image in [makeAMistakeImageView, askTheAudienceImageView, fiftyFiftyImageView] {
            //            добавить действие на изображения
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
        let maxSeconds: Float = 30
        valueSecond = 30
        progressView.progress = valueSecond / maxSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.valueSecond == 0 {
                self.timer?.invalidate()
                // проигрыш
                let looseVC = FinalVC()
                looseVC.winnedMoney = self.millionaireBrain.getFireproofCash()
                self.navigationController?.pushViewController(looseVC, animated: true)
            }
            self.valueSecond -= 1
            self.progressView.progress = self.valueSecond / maxSeconds
        })
    }
    
    //    меняем спейсинг стак вью с вопросами при повороте экрана
    override func viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator){
        if UIDevice.current.orientation.isLandscape {
            answersStackView.spacing = 6
        } else {
            answersStackView.spacing = 25
        }
    }
    
}


extension QuestionsScreenViewController: QuestionListVCDelegate {
    func viewClosed() {
        millionaireBrain.nextQuestion()
        updateView()
    }
}
