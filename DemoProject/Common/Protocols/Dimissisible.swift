import UIKit

protocol Dimissisible {
    func close()
}

extension Dimissisible  where Self: UIViewController {
    func close() {
        self.close(animated: true, completion: nil)
    }
}
