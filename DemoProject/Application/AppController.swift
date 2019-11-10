import UIKit

protocol AppControllerType: class, Alertable {
    func display(viewControllers: [UIViewController])
    func setTabBar(color: UIColor)
}

class AppController: UITabBarController {
    
    // MARK: - Private
    var presenter: AppPresenterType!
    
    // MARK: - Init
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }
    
    // MARK: - Gesture methods
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            presenter.toggleAppConnectionMode()
        }
    }
}

extension AppController: AppControllerType {
    func display(viewControllers: [UIViewController]) {
        setViewControllers(viewControllers, animated: true)
    }
    func setTabBar(color: UIColor) {
        self.tabBar.backgroundColor = color
    }
}
