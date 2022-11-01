//
//  Question.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Дария Григорьева on 01.11.2022.
//

import Foundation

struct Question {
    let text: String
    let answer: [String]
    let correctAnswer: String
    
    init(t: String, a: [String], correctAnswer: String) {
        text = t
        answer = a
        self.correctAnswer = correctAnswer
        
    }
}
