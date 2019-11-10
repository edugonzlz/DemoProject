import UIKit

extension UIApplication {
    static var appController: AppController? {
        return UIApplication.shared.keyWindow?.rootViewController as? AppController
    }
    
    static func topViewController() -> UIViewController? {
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedController = rootVC?.presentedViewController {
            rootVC = presentedController
        }
        
        guard rootVC != nil else {
            return nil
        }
        return rootVC
    }
}
