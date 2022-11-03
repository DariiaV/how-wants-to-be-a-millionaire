import Foundation
import AVFoundation

class AudioManager {
    
    private var player: AVAudioPlayer?
    
    func playSound(soundName: String?) {
        guard let path = Bundle.main.path(forResource: soundName, ofType:"mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopPlay() {
        player?.stop()
    }
}

