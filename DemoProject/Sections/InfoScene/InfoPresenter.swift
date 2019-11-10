import Foundation

protocol InfoPresenterType {
    func navigateToRepo()
    func logout()
}

class InfoPresenter {

    // MARK: - Public
    var interactor: InfoInteractorType?
    var loginInteractor: LoginInteractorType?
    
    // MARK: - Private
    private var wireframe: InfoWireframeType
    private weak var viewController: InfoViewControllerType?
    
    // MARK: - Init
    init(wireframe: InfoWireframeType,
         viewController: InfoViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

extension InfoPresenter: InfoPresenterType {
    func navigateToRepo() {
        URL(string: "https://github.com/edugonzlz/DemoProject")?.openInApp()
    }

    func logout() {
        loginInteractor?.logout()
        wireframe.navigateToMainApp()
    }
}
