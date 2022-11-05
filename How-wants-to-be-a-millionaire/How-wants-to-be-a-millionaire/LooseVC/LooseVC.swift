import UIKit

class LooseVC: UIViewController {

    @IBOutlet weak var attemptLabel: UILabel!
    @IBOutlet weak var finalMoneyLabel: UILabel!
    @IBOutlet weak var winLoseMessageLabel: UILabel!
    
//    В эту переменную должно передаваться количество выйгранных денег
    var winnedMoney = 0
    
    private var prizeBrain = PrizeBrain()
    
//    Три лейбла - attemptLabel, который содержит основное сообщение, finalMoneyLabel, который отображается количество денег и winLoseMessageLabel, отображающий три сообщения о победе или проигрыше
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptLabel.text = prizeBrain.printFinalResultText()
        finalMoneyLabel.text = String(winnedMoney) + "p"
        winLoseMessageLabel.text = prizeBrain.printWinLoseMessage()
        navigationController?.setNavigationBarHidden(true, animated: true)

    }

    @IBAction func playAgainPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
