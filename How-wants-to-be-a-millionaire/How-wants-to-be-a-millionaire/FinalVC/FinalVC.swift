import UIKit

class FinalVC: UIViewController {

    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var finalMoneyLabel: UILabel!
    @IBOutlet weak var winLoseMessageLabel: UILabel!
    
//    В эту переменную должно передаваться количество выйгранных денег
    var winnedMoney = 0
    
    private var prizeBrain = PrizeBrain()
    private let player = AudioManager()
    
    var state = GameState.getMoney
    
//    Три лейбла - attemptLabel, который содержит основное сообщение, finalMoneyLabel, который отображается количество денег и winLoseMessageLabel, отображающий три сообщения о победе или проигрыше
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptLabel.text = prizeBrain.getFinalResultText(state: state)
        finalMoneyLabel.text = String(winnedMoney) + "p"
        if state == .win {
            player.playSound(soundName: "playerWon")
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    @IBAction func playAgainPressed(_ sender: UIButton) {
        player.stopPlay()
        navigationController?.popToRootViewController(animated: true)
    }
    
    //    фиксирую этот экран в портретном режиме
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    //    после закрытия этого экрана разрешаю другим экранам менять ориентацию в зависимости от положения девайса
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
}
