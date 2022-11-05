import Foundation

struct PrizeBrain {
    private var finalPrizeInfo = [
        PrizePrint(textMessage: "Повезёт в следующий раз", winLoose: "Lose"),
        PrizePrint(textMessage: "Вы решили забрать деньги", winLoose: "Win?"),
        PrizePrint(textMessage: "Поздравляем Вас с победой!", winLoose: "Win")
    ]
    
    private var currentState = 0
    
//    Эта функция возвращает основной текст для сообщения
    func printFinalResultText() -> String {
        finalPrizeInfo[currentState].textMessage
    }
    
//    Эта функция возвращает короткое сообщение о победе или проигрыше
    func printWinLoseMessage() -> String {
        finalPrizeInfo[currentState].winLoose
    }
    
//    Функция, которая меняет позицию в массиве на вариант, когда пользователь забирает деньги
    mutating func printTakeMoney() {
        currentState = 1
    }
    
//    Функция, которая меняет позицию в массиве на вариант, когда пользователь побеждает
    mutating func printTotalWin() {
        currentState = 2
    }
    
}
