import UIKit

protocol ListWireframeType {
    func start()
    func navigateTo(account: AccountEntity, newAlias: ((String?) -> Void)?)
    func navigateTo(card: CardEntity, newAlias: ((String?) -> Void)?)
}

struct ListWireframe: ListWireframeType {

    weak var navigationController: UINavigationController?

    func start() {
        
        let viewController = ListViewController()
        let presenter = ListPresenter(wireframe: self, viewController: viewController)
        let interactor = ListInteractor(userService: UserService(requestManager: RequestManager.shared))
        viewController.presenter = presenter
        presenter.interactor = interactor

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateTo(account: AccountEntity, newAlias: ((String?) -> Void)?) {
        var wireframe = DetailWireframe(navigationController: self.navigationController, newAlias: newAlias)
        wireframe.account = account
        wireframe.start()
    }
    
    func navigateTo(card: CardEntity, newAlias: ((String?) -> Void)?) {
        var wireframe = DetailWireframe(navigationController: self.navigationController, newAlias: newAlias)
        wireframe.card = card
        wireframe.start()
    }
}
