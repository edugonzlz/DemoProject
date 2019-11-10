import Foundation

struct UserTableData {
    let username: String
    let data: [UserSection]
}

enum UserSection {
    case accounts(items: [AccountEntity])
    case cards(items: [CardEntity])
}

protocol ListPresenterType {
    func getData()
    func navigateTo(detail indexPath: IndexPath)
}

class ListPresenter {

    // MARK: - Public
    var interactor: ListInteractorType?
    
    
    // MARK: - Private
    private var wireframe: ListWireframeType
    private weak var viewController: ListViewControllerType?
    private var data: UserTableData?
    
    // MARK: - Init
    init(wireframe: ListWireframeType,
         viewController: ListViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

extension ListPresenter: ListPresenterType {
    func getData() {
        interactor?.getUser { result in
            switch result {
            case .success(let user):
                let data = UserTableData(username: user.name,
                                         data: [UserSection.accounts(items: user.accounts),
                                                UserSection.cards(items: user.cards)])
                self.data = data
                self.viewController?.present(data: data)
                
            case .failure(let message):
                self.viewController?.showAlert(title: "Attention", message: message)
            }
        }
    }

    func navigateTo(detail indexPath: IndexPath) {
        if let section = data?.data[indexPath.section] {
            switch section {
            case .accounts(let items):
                let item = items[indexPath.row]
                
                self.wireframe.navigateTo(account: item) { newAlias in
                    if let newAlias = newAlias, let data = self.data {
                        item.alias = newAlias
                        self.viewController?.present(data: data)
                    }
                }
                
            case .cards(let items):
                let item = items[indexPath.row]
                
                self.wireframe.navigateTo(card: item) { newAlias in
                    if let newAlias = newAlias, let data = self.data {
                        item.alias = newAlias
                        self.viewController?.present(data: data)
                    }
                }
            }
        }
    }
}
