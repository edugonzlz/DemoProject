import UIKit

protocol AppWireframeType {
    func start()
    func createDataTab() -> UIViewController
    func createInfoTab() -> UIViewController
    func presentLogin()
}

class AppWireframe {
	
	private weak var window: UIWindow?
    private var appController: AppController?
    
    init(_ window: UIWindow?) {
        self.window = window
    }
}

extension AppWireframe: AppWireframeType {
    func start() {
        let interactor = AppInteractor()
        let appViewController = AppController()
        let presenter = AppPresenter(wireframe: self, viewController: appViewController)
        appViewController.presenter = presenter
        presenter.interactor = interactor
        self.appController = appViewController
        
        presenter.configureApp()
        window?.rootViewController = appViewController
    }
    
    func createDataTab() -> UIViewController {
        let navVC = UINavigationController()
        navVC.tabBarItem = TabBarItem.data.value
        let wireframe = ListWireframe(navigationController: navVC)
        wireframe.start()
        return navVC
    }
    
    func createInfoTab() -> UIViewController {
        let navVC = UINavigationController()
        navVC.tabBarItem = TabBarItem.info.value
        let wireframe = InfoWireframe(navigationController: navVC)
        wireframe.start()
        return navVC
    }
    
    func presentLogin() {
        guard let appController = appController else { return }
        let wireframe = LoginWireframe(appController)
        wireframe.start()
    }
}
