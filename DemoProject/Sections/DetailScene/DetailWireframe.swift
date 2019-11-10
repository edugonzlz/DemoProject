import UIKit

protocol DetailWireframeType {
    func start()
}

struct DetailWireframe: DetailWireframeType {

    weak var navigationController: UINavigationController?
    var newAlias: ((String?) -> Void)? = nil
    var account: AccountEntity? = nil
    var card: CardEntity? = nil

    init(navigationController: UINavigationController?, newAlias: ((String?) -> Void)?) {
        self.navigationController = navigationController
        self.newAlias = newAlias
    }
    
    func start() {
        
        let viewController = DetailViewController()
        let presenter = DetailPresenter(wireframe: self, viewController: viewController)
        let interactor = DetailInteractor()
        interactor.account = account
        interactor.card = card
        presenter.interactor = interactor
        presenter.newAlias = newAlias
        viewController.presenter = presenter

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
