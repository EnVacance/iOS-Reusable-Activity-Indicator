
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
        
        // lenghtを１にしないと、TableView等でその部分がScroll不可になる
        // length0でもActivityIndicatorは正しく表示される
        let aiLength: CGFloat = 1
        [
            ai.widthAnchor.constraint(equalToConstant: aiLength),
            ai.heightAnchor.constraint(equalToConstant: aiLength),
            ai.centerYAnchor.constraint(equalTo: centerYAnchor),
            ai.centerXAnchor.constraint(equalTo: centerXAnchor),
        ].forEach { $0.isActive = true  }
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


