import Foundation

protocol DetailPresenterType {
    func getData()
    func set(newAlias: String?)
}

class DetailPresenter {

    // MARK: - Public
    var interactor: DetailInteractorType?
    var newAlias: ((String?) -> Void)? = nil
    
    // MARK: - Private
    private var wireframe: DetailWireframeType
    private weak var viewController: DetailViewControllerType?
    
    // MARK: - Init
    init(wireframe: DetailWireframeType,
         viewController: DetailViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

extension DetailPresenter: DetailPresenterType {
    func getData() {
        if let item = interactor?.getData() {
            viewController?.present(item: item)
        }
    }
    
    func set(newAlias: String?) {
        self.newAlias?(newAlias)
    }
}
