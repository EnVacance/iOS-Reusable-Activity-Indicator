
import UIKit

public class ReusableActivityIndicatorSettings: NSObject {
    
    public static var shared: ReusableActivityIndicatorSettings = ReusableActivityIndicatorSettings()
    
    public var style: UIActivityIndicatorView.Style = .gray
}

