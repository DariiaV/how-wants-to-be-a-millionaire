import UIKit

class LooseVC: UIViewController {

    @IBOutlet weak var attemptLabel: UILabel!
    var attempt = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptLabel.text = "Вы проиграли на \(attempt + 1) вопросе"
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
