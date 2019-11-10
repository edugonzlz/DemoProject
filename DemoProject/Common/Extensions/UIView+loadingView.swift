import UIKit

extension UIView {
    
    weak var loadingView: LoadingView? {
        get {
            let view = subviews.first(where: { $0 is LoadingView })
            return view as? LoadingView
        }
        set {
            let oldView = self.loadingView
            
            guard let loadingView = newValue else {
                oldView?.removeFromSuperview()
                return
            }
            
            oldView?.removeFromSuperview()
            addViewToBoundsWithContraints(loadingView)
        }
    }
    
    func showLoading() {
        let view = LoadingView.instantiate()
        
//        let view = UINib(nibName: String(describing: LoadingView.self), bundle: nil)
//            .instantiate(withOwner: nil, options: nil).first as! LoadingView
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.setup()
        loadingView = view
    }
    
    func hideLoading() {
        loadingView = nil
    }
}
