import Foundation

struct PrizeBrain {
    //    Эта функция возвращает основной текст для сообщения
    func getFinalResultText(state: GameState) -> String {
        switch state {
        case .lose:
            return  "Повезёт в следующий раз"
        case .win:
            return  "Поздравляем Вас с победой!"
        case .getMoney:
            return   "Вы решили забрать деньги"
        case .nextQuestion:
            return ""
        }
    }
    
}
