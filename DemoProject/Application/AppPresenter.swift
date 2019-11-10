import UIKit

protocol AppPresenterType: class {
    func configureApp()
    func presentLogin()
    func toggleAppConnectionMode()
}

class AppPresenter {
    
    var interactor: AppInteractorType?
    
    private weak var viewController: AppControllerType?
    private let wireframe: AppWireframeType
    
    init(wireframe: AppWireframeType, viewController: AppControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

extension AppPresenter: AppPresenterType {
    func configureApp() {
        configureTabBarController()
        checkUserSession()
    }
    
    func presentLogin() {
        wireframe.presentLogin()
    }

    func toggleAppConnectionMode() {
        var title = ""
        var message = ""
        switch Config.appConnectionMode {
        case .network:
            Config.appConnectionMode = .localMocks
            title = "Attention"
            message = "Activating the simulated mode"
            self.setTabBarColor()
        case .localMocks:
            Config.appConnectionMode = .network
            title = "Attention"
            message = "Activating the network mode"
            self.setTabBarColor()
        }
        let alert = AlertController.alert(title: title, message: message)
        UIApplication.topViewController()?.present(alert, animated: true)
    }

}

fileprivate extension AppPresenter {
    func checkUserSession() {
        guard let interactor = interactor else { return }
        DispatchQueue.main.async {
            if !interactor.isUserLogged() {
                self.wireframe.presentLogin()
            }
        }
    }
    
    func configureTabBarController() {
        guard let tabs = interactor?.getTabs() else { return }
        
        self.setTabBarColor()

        var viewControllers = [UIViewController]()
        
        tabs.enumerated().forEach({ item in
            self.configure(tabBarItem: item.element.value,
                           insets: item.element.contentInset,
                           titleOffset: item.element.titleOffset)
            
            switch item.element {
            case .data:
                viewControllers.append(wireframe.createDataTab())
            case .info:
                viewControllers.append(wireframe.createInfoTab())
            }
        })
        
        viewController?.display(viewControllers: viewControllers)
    }
    
    func configure(tabBarItem: UITabBarItem,
                   insets: UIEdgeInsets,
                   titleOffset: UIOffset) {
//        tabBarItem.image = tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        tabBarItem.imageInsets = insets
        tabBarItem.titlePositionAdjustment = titleOffset
    }
    
    func setTabBarColor() {
        var color: UIColor
        switch Config.appConnectionMode {
        case .network:
            color = .white
        case .localMocks:
            color = .red
        }
        self.viewController?.setTabBar(color: color)
    }
}
