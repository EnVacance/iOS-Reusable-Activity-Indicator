
import UIKit

public class ReusableActivityIndicatorSettings: NSObject {
    
    public static var shared: ReusableActivityIndicatorSettings = ReusableActivityIndicatorSettings()
    
    override init() {
        super.init()
    }
    
    public var style: UIActivityIndicatorView.Style = .gray
}

