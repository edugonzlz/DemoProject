import Foundation

protocol LoginPresenterType {
    func username(_ text: String?)
    func password(_ text: String?)
    func loginButtonTapped()
}

class LoginPresenter {
    
    // MARK: - Public
    var interactor: LoginInteractorType?
    
    // MARK: - Private
    private var wireframe: LoginWireframeType
    private weak var viewController: LoginViewControllerType?
    
    // MARK: - Init
    init(wireframe: LoginWireframeType,
         viewController: LoginViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

extension LoginPresenter: LoginPresenterType {
    func username(_ text: String?) {
        interactor?.validate(username: text) { error in
            self.viewController?.usernameIsValid(error: error)
        }
        validateForm()
    }
    
    func password(_ text: String?) {
        interactor?.validate(password: text) { error in
            self.viewController?.passwordIsValid(error: error)
        }
        validateForm()
    }
    
    func loginButtonTapped() {
        viewController?.showLoading()
        interactor?.login { result in
            self.viewController?.hideLoading()
            switch result {
            case .success:
                self.viewController?.close()
            case .failure(let message):
                self.viewController?.showAlert(title: "Attention", message: message)
            }
        }
    }

}

private extension LoginPresenter {
    func validateForm() {
        interactor?.formIsValid() { valid in
            self.viewController?.enableLoginButton(valid)
        }
    }
}
