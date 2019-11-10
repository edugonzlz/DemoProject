import UIKit

protocol InfoWireframeType {
    func start()
    func navigateToMainApp()
}

struct InfoWireframe: InfoWireframeType {

    weak var navigationController: UINavigationController?

    func start() {
        
        let viewController = InfoViewController()
        let presenter = InfoPresenter(wireframe: self, viewController: viewController)
        viewController.presenter = presenter
        presenter.interactor = InfoInteractor()
        presenter.loginInteractor = LoginInteractor(loginService: LoginService(requestManager: RequestManager.shared),
                                                    keychain: KeychainManager(),
                                                    validationService: ValidationService())
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToMainApp() {
//        UIApplication.mainNavigationController?.interactor?.routeToLoginDecission(completion: nil)

        UIApplication.appController?.presenter.presentLogin()
    }
}
