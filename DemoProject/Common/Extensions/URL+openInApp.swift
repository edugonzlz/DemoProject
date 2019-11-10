import UIKit

extension URL {
    func openInApp() {
        if UIApplication.shared.canOpenURL(self) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(self)
            } else {
                if UIApplication.shared.canOpenURL(self) {
                    UIApplication.shared.openURL(self)
                }
            }
        }
    }
}
