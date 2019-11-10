import UIKit

extension UIViewController {
    func embedInNavigation() -> UINavigationController {
        return UINavigationController.init(rootViewController: self)
    }
}

extension UIViewController {
    @objc func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        if presentingViewController != nil {
            dismiss(animated: animated, completion: completion)
        } else {
            self.navigationController?.popViewController(animated: animated)
        }
    }
}

extension UIViewController {
    func showLoading() {
        view.showLoading()
    }
    func hideLoading() {
        view.hideLoading()
    }
}
