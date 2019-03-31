
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wideRectangleView: UIView!
    @IBOutlet weak var tallRectangleView: UIView!
    @IBOutlet weak var squareView: UIView!
    
    
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

