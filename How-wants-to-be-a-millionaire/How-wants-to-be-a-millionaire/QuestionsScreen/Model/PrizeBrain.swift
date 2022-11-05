import Foundation

struct PrizeBrain {
    var finalPrizeInfo = [
        PrizePrint(textMessage: "Повезёт в следующий раз", winLoose: "Lose"),
        PrizePrint(textMessage: "Вы решили забрать деньги", winLoose: "Win?"),
        PrizePrint(textMessage: "Поздравляем Вас с победой!", winLoose: "Win")
    ]
    
    var currentState = 0
    
    func printFinalResultText() -> String {
        finalPrizeInfo[currentState].textMessage
    }
    
    func printWinLoseMessage() -> String {
        finalPrizeInfo[currentState].winLoose
    }
    
    mutating func printTakeMoney() {
        currentState = 1
    }
    
    mutating func printTotalWin() {
        currentState = 2
    }
    
}
