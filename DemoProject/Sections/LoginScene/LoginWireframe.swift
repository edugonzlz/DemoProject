import UIKit

protocol LoginWireframeType {
    func start()
}

class LoginWireframe: LoginWireframeType {
    
    private weak var viewController: UIViewController?
    private weak var window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
        self.viewController = nil
    }
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
        self.window = nil
    }
    
    func start() {
        let loginVC = LoginViewController()
        let presenter = LoginPresenter(wireframe: self, viewController: loginVC)
        let loginService = LoginService(requestManager: RequestManager.shared)
        let interactor = LoginInteractor(loginService: loginService, keychain: KeychainManager(), validationService: ValidationService())
        loginVC.presenter = presenter
        presenter.interactor = interactor
        
        if let window = window {
            window.rootViewController = loginVC
        } else if let viewController = self.viewController {
            viewController.present(loginVC, animated: true)
        }
    }
}
