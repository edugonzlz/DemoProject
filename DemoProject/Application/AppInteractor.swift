import Foundation

protocol AppInteractorType {
    func getTabs() -> [TabBarItem]
    func isUserLogged() -> Bool
}

class AppInteractor {
    
    private let loginInteractor: LoginInteractorType
    
    init(loginInteractor: LoginInteractorType = LoginInteractor(loginService: LoginService(requestManager: RequestManager.shared),
                                                                keychain: KeychainManager(),
                                                                validationService: ValidationService())) {
        self.loginInteractor = loginInteractor
    }
}

extension AppInteractor: AppInteractorType {
    func isUserLogged() -> Bool {
        return loginInteractor.userIsLogged()
    }
    
    func getTabs() -> [TabBarItem] {
        return [.data, .info]
    }
}
