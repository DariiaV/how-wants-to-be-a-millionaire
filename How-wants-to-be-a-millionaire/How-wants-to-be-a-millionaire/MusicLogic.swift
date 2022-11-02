import Foundation
import AVFoundation

var player: AVAudioPlayer!

// Эта функция бесконечно проигрывает музыку благодаря свойству numberOfLoops. Можно использовать для прогирывания музыки, пока пользователь думает над ответом.

func playBackgroundSound(literalOfSound: String) {
    let url = Bundle.main.url(forResource: СЮДА НУЖНО ПОДСТАВИТЬ НАЗВАНИЕ ТРЕКА, withExtension: ТУТ УКАЗАТЬ РАСШИРЕНИЕ ТРЕКА В ДВОЙНЫХ КОВЫЧКАХ)
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
    player.numberOfLoops = -1
    
}

// Конструкция для верного и неверного ответа одинаковая, и представлена снизу. Она одинаковая для обоих случаев

func playAnwersSound(literalOfSound: String) {
    let url = Bundle.main.url(forResource: СЮДА НУЖНО ПОДСТАВИТЬ НАЗВАНИЕ ТРЕКА, withExtension: ТУТ УКАЗАТЬ РАСШИРЕНИЕ ТРЕКА В ДВОЙНЫХ КОВЫЧКАХ)
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()

}

// Конструкция для проигрывания музыки при принятии ответа. Только для его работы нужно будет создать переменную timeLimit: Double, где будет в секундах указана длинна проигрываемого трека

func playAnwerIsAcceptedSound(literalOfSound: String) {
    let url = Bundle.main.url(forResource: СЮДА НУЖНО ПОДСТАВИТЬ НАЗВАНИЕ ТРЕКА, withExtension: ТУТ УКАЗАТЬ РАСШИРЕНИЕ ТРЕКА В ДВОЙНЫХ КОВЫЧКАХ)
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
    
    Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: false) { (timer) in
        self.player.stop()
    }
