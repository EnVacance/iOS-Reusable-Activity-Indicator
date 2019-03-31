
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}


// MARK: - Event

extension ViewController {
    
    @IBAction func startButtonTap(_ sender: Any) {
        print("Start")
    }
    
    @IBAction func stopButtonTap(_ sender: Any) {
        print("Stop")
    }
    
}

