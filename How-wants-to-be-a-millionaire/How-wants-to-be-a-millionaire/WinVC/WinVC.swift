import UIKit

class WinVC: UIViewController {
    
    @IBOutlet weak var prizeLabel: UILabel!
    var prize = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prizeLabel.text = String(0)
        print(prize)
    }
    
    
    
}
