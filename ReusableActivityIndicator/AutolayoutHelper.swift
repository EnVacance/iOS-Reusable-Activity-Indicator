
import Foundation

extension UIView {
    
    /// isActive is set to true automatically
    func addAnchorsEdged(equalTo view: UIView) {
        [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor)
        ].forEach{ $0.isActive = true }
    }
}
