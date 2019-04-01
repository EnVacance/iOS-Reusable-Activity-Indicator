# iOS-Reusable-Activity-Indicator
One method to display indicator!

A swift module enables displaying UIActivityIndicator on any view by just calling one method.  
It dispalys UIActivityIndicaotr at the center of a view.  

UIActivityIndicator.Style can be configured either globally or at the point of the method call(overrides global style setting).

## Example

<img width="400" alt="Screenshot" src="https://user-images.githubusercontent.com/16092178/55290388-acaf7a00-540d-11e9-9eda-e9ef87a0513f.png">  <img width="400" alt="Screenshot" src="https://user-images.githubusercontent.com/16092178/55291531-63b1f280-541a-11e9-8000-2ecb1e80230c.png">


## Usage
```swift

import UIKit
import ReusableActivityIndicator // ■1. IMPORT: Just import and will be ready to use on any view

class ViewController: UIViewController {

    @IBOutlet weak var wideRectangleView: UIView!
    @IBOutlet weak var tallRectangleView: UIView!
    @IBOutlet weak var squareView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ■2. STYLE: Setting style globally
        ReusableActivityIndicatorSettings.shared.style = .gray
    }
}


// MARK: - Event

extension ViewController {
    
    /*
      ■3. START: 
      To start animating activity indicator, call activityIndicatorStart() method
      from an instance of UIView or its subclass.
    */
    @IBAction func startButtonTap(_ sender: Any) {
        wideRectangleView.activityIndicatorStart()
        tallRectangleView.activityIndicatorStart()
        
        // Overriding global style setting
        squareView.activityIndicatorStart(style: .whiteLarge)
    }
    
    /*
      ■4. STOP: 
      To stop animating acitity indicator, call activityIndicatorStop() method
      from an instance of UIView or its subclass.
    */
    @IBAction func stopButtonTap(_ sender: Any) {
        wideRectangleView.activityIndicatorStop()
        tallRectangleView.activityIndicatorStop()
        squareView.activityIndicatorStop()
    }
    
}
```



## How it works
Essential part of the code here.

What it does is simply adding a new UIActivityIndicatorView to a view when called to display an indicaotor & removes it when called to stop the indicator.

```swift
import Foundation
import UIKit


extension UIView {
    
    /**
     For removing indicator.
     Subclass with a specific name that it can be identified within view hierarchy it is added.
     
     Indicatorをadd subviewされたviewからremoveするために宣言。Viewのヒエラルキーをiterateしてこのクラスを探し出すことで、
     このファイル内部でadd subviewされたとわかる。
     */
    private class MyActivityIndicatorView: UIActivityIndicatorView {}
    
    
    
    // MARK: - Property
    
    /**
     Place the indicator at the center of the superview
     Super viewの中心へincicatorを配置
    */
    private var makeIndicator: MyActivityIndicatorView {
        let ai = MyActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.center = self.center
        ai.hidesWhenStopped = true
        return ai
    }
    
    
    
    // MARAK: - Pullic
    
    public func activityIndicatorStart(style customStyle: UIActivityIndicatorView.Style? = ReusableActivityIndicatorSettings.shared.style) {
        
        let style = customStyle ?? ReusableActivityIndicatorSettings.shared.style
        
        /*
         Without this, it might add more than one indicator on the view.
         これをしないと複数のindicatorを同一viewに追加してしまう。
        */
        guard isSubviewsContainsMyActivityIndicator == false else {
            return
        }
        
        
        let ai = makeIndicator
        ai.style = style
        
        addSubview(ai)
        ai.addAnchorsEdged(equalTo: self)
        ai.startAnimating()
    }
    
    public func activityIndicatorStop() {
        subviews.forEach {
            /*
             Retreive the indicator from subviews which is added in func activityIndicatorStart()
             func activityIndicatorStart()でadd subviewしたindicatorをviewのsubviewから取り出す
            */
            guard let myActivityIndicator = $0 as? MyActivityIndicatorView else { return }
           
            
            /*
             To prevent a new indicator is ketp added to the view everytime start animating indicator,
             revemo it after stopped.
             
             Indicaotrを表示するたびに新しいindicatorがadd subviewされ続けてしまうことを回避するため、
             毎回stopした後にremoveする。
            */
            myActivityIndicator.stopAnimating()
            myActivityIndicator.removeFromSuperview()
        }
    }
    
    
    
    // MARK: - Helper
    
    private var isSubviewsContainsMyActivityIndicator: Bool {
        return subviews.contains { $0 is MyActivityIndicatorView }
    }
}


```
