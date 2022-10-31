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
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    @IBOutlet weak var makeAMistakeImageView: UIImageView!
    @IBOutlet weak var askTheAudienceImageView: UIImageView!
    @IBOutlet weak var fiftyFiftyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in [makeAMistakeImageView, askTheAudienceImageView, fiftyFiftyImageView] {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped(_:)))
            image?.isUserInteractionEnabled = true
            image?.addGestureRecognizer(tap)
        }
        
        for button in [buttonAView, buttonBView, buttonCView, buttonDView] {
            let tap = UITapGestureRecognizer(target: self, action: #selector(buttonDidTapped(_:)))
            button?.addGestureRecognizer(tap)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for button in [buttonAView, buttonBView, buttonCView, buttonDView] {
            button?.clipsToBounds = true
            button?.layer.cornerRadius = 20
        }
        
    }
    
    @objc private func imageViewDidTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc private func buttonDidTapped(_ sender: UITapGestureRecognizer) {
        
    }
}
