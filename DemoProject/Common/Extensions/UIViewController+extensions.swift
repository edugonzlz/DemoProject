import UIKit

extension UIViewController {
    @objc func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        if presentingViewController != nil {
            dismiss(animated: animated, completion: completion)
        } else {
            self.navigationController?.popViewController(animated: animated)
        }
    }
}
