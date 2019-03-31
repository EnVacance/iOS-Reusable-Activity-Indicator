
import UIKit
import ReusableActivityIndicator

class ViewController: UIViewController {

    @IBOutlet weak var wideRectangleView: UIView!
    @IBOutlet weak var tallRectangleView: UIView!
    @IBOutlet weak var squareView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting style globally
        ReusableActivityIndicatorSettings.shared.style = .gray
    }
}


// MARK: - Event

extension ViewController {
    
    @IBAction func startButtonTap(_ sender: Any) {
        wideRectangleView.activityIndicatorStart()
        tallRectangleView.activityIndicatorStart()
        
        // Overring global style setting
        squareView.activityIndicatorStart(style: .whiteLarge)
    }
    
    @IBAction func stopButtonTap(_ sender: Any) {
        wideRectangleView.activityIndicatorStop()
        tallRectangleView.activityIndicatorStop()
        squareView.activityIndicatorStop()
    }
    
}

