//
//  MillionaireBrain.swift
//  How-wants-to-be-a-millionaire
//
//  Created by Дария Григорьева on 01.11.2022.
//

import Foundation

struct MillionaireBrain {
   private let quiz = [
    Question(t: "Как называют беспилотный летательный аппарат?",
             a: ["дрон", "фаэтон", "махаон", "десептикон"],
             correctAnswer: "дрон"),
    Question(t: "В какой игре не используют мяч?",
             a: ["волейбол", "бейсбол", "теннис", "керлинг" ],
             correctAnswer: "керлинг"),
    Question(t: "Что в сказках было семимильным?",
             a: ["ковер", "одежда", "сапоги", "мотоцикл"],
             correctAnswer: "ковер"),
    Question(t: "Как называют специалиста, избавляющего лес от болезней и вредителей?",
             a: ["лесник", "лесовик", "леший", "лесопатолог" ],
             correctAnswer: "лесопатолог"),
    Question(t: "Какое слово трижды встречается в романе «Евгений Онегин»?",
             a: ["кино", "сплин", "аквариум", "зоопарк"],
             correctAnswer: "сплин"),
    Question(t: "Какой элемент получил свое название из-за синей линии в его спектре?",
             a: ["родий", "индий", "церий", "нептуний"],
             correctAnswer: "индий"),
    Question(t: "Участники какой группы записали песню, которую случайно нашли на чердаке дома в Великобритании в ноябре 2021 года?",
             a: ["«Битлз»", "«Квин»", "«Роллинг стоунз»", "«Пинк флойд»"],
             correctAnswer: "«Битлз»"),
    Question(t: " В каком из этих фильмов Марка Захарова снимался Александр Абдулов, но не снимался Олег Янковский?",
             a: ["«12 стульев»", "«Дом, который построил Свифт»", "«Обыкновенное чудо»", "«Убить дракона»"],
             correctAnswer: "«12 стульев»"),
    Question(t: "Что итальянцы называют «мадоннари»?",
             a: ["рисунки на асфальте", "вуаль", "период в искусстве", "сорт яблок"],
             correctAnswer: "рисунки на асфальте"),
    Question(t: "Какой мультфильм Уолт Дисней передал Советскому Союзу в честь победы во Второй мировой войне?",
             a: ["«Белоснежка и семь гномов»", "«Привет, друзья!»", "«Бэмби»", "«Дамбо»"],
             correctAnswer: "«Бэмби»"),
    Question(t: "Как называется животное из семейства крыланов?",
             a: ["летучий заяц", "летучий волк", "летучая лисица", "летучий медведь"],
             correctAnswer: "летучая лисица"),
    Question(t: "Где установлена скульптура, которую до войны считали богиней мира Эйреной, а после войны – богиней победы Викторией?",
             a: ["на портике Лувра", "на холме Палатин в Риме", "на Бранденбургских воротах", "перед Букингемским дворцом"],
             correctAnswer: "на Бранденбургских воротах"),
    Question(t: "Где можно найти пятно Ктулху и бороду Слейпнир?",
             a: ["на Сатурне", "на Уране", "на Нептуне", "на Плутоне"],
             correctAnswer: "на Плутоне"),
    Question(t: "На дочери какого поэта был женат сын писателя Сергея Аксакова?",
             a: ["Александра Пушкина", "Федора Тютчева", "Афанасия Фета", "Алексея Плещеева"],
             correctAnswer: "Федора Тютчева"),
    Question(t: "Какой вид спорта соответствовал номеру 6 в лотерее «Спортлото» 6 из 49 в 1970 году?",
             a: ["баскетбол", "биатлон", "бокс", "волейбол"],
             correctAnswer: "баскетбол"),
    ]
    
    private let cashPrices = [
        CashPrice(price: 100, fireproof: false),
        CashPrice(price: 200, fireproof: false),
        CashPrice(price: 300, fireproof: false),
        CashPrice(price: 500, fireproof: false),
        CashPrice(price: 1000, fireproof: true),
        CashPrice(price: 2000, fireproof: false),
        CashPrice(price: 4000, fireproof: false),
        CashPrice(price: 8000, fireproof: false),
        CashPrice(price: 16000, fireproof: false),
        CashPrice(price: 32000, fireproof: true),
        CashPrice(price: 64000, fireproof: false),
        CashPrice(price: 125000, fireproof: false),
        CashPrice(price: 250000, fireproof: false),
        CashPrice(price: 500000, fireproof: false),
        CashPrice(price: 1000000, fireproof: true)
    ]

    private var questionNumber = 5
    private var mistakeCount = 2
    private var fireproofNumber = 0
    
    
    func getQuestionText() -> String {
        quiz[questionNumber].text
    }
    
    func getCurrentNumber() -> Int {
        questionNumber
    }
    
    func getQuestionNumberText() -> String {
        "Вопрос \(questionNumber + 1)"
    }
    
    func getCashText() -> String {
        "\(cashPrices[questionNumber].price) RUB"
    }
    
    func getCashNumber(state: GameState) -> Int {
        if state == .getMoney {
            return cashPrices[questionNumber - 1].price
        } else if state == .lose && fireproofNumber != 0 {
            return cashPrices[fireproofNumber].price
        } else {
            return  cashPrices[questionNumber].price
        }
    }
    
    func getAnswerText(_ number: Int) -> String {
        quiz[questionNumber].answer[number]
    }
    
    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            fireproofNumber = cashPrices[questionNumber].fireproof
            ? questionNumber
            : fireproofNumber
            questionNumber += 1
        } else {
            questionNumber = 0
            
        }
    }
    
    mutating func checkAnswerAndGetCurrentIndex(_ userAnswer: Int) -> (Bool, Int) {
        let answer = getAnswerText(userAnswer) == quiz[questionNumber].correctAnswer
        return (answer, getIndexOfCurrentAnswer())
    }
    
    mutating func userGetMistake() {
        mistakeCount -= 1
    }
    
    func getMistakeCount() -> Int {
        mistakeCount
    }
    
    func fiftyFifty() -> (index1: Int, index2: Int) {
        let correctIndex = getIndexOfCurrentAnswer()
        let index1 = 0 == correctIndex ? 1 : 0
        let index2 = 2 == correctIndex ? 3 : 2
        return (index1, index2)
    }
    
    private func getIndexOfCurrentAnswer() -> Int {
        let correctA = quiz[questionNumber].correctAnswer
        guard let currentAnswer = quiz[questionNumber].answer.firstIndex(of: correctA) else {
            return 0
        }
        
        return currentAnswer
    }
    
    func getCorrectLetter() -> String {
        switch getIndexOfCurrentAnswer() {
        case 0: return "A"
        case 1: return "B"
        case 2: return "C"
        default: return "D"
            
        }
    }
    
    func getFireproofCash() -> Int {
        if fireproofNumber == 0 {
            return 0
        } else {
            return cashPrices[fireproofNumber].price
        }
    }
}
