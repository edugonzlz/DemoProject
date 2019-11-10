import Foundation

protocol LoginInteractorType: class {
    func userIsLogged() -> Bool
    func validate(username: String?, completion: @escaping (String?) -> Void)
    func validate(password: String?, completion: @escaping (String?) -> Void)
    func formIsValid(completion: @escaping (Bool) -> Void)
    func login(completion: @escaping (Result<Bool, ErrorMessage>) -> Void)
    func logout()
}

class LoginInteractor {
    
    private let loginService: LoginServiceType
    private let keychain: KeychainManagerType
    private let validationService: ValidationServiceType
    
    private var username: String?
    private var password: String?
    private var usernameIsValid: Bool = false
    private var passwordIsValid: Bool = false
    
    init(loginService: LoginServiceType,
         keychain: KeychainManagerType,
         validationService: ValidationServiceType) {
        self.loginService = loginService
        self.keychain = keychain
        self.validationService = validationService
    }
}

extension LoginInteractor: LoginInteractorType {
    func userIsLogged() -> Bool {
        return keychain.get(key: KeychainKey.authToken) != nil
    }
    
    func validate(username: String?, completion: @escaping (String?) -> Void) {
        self.username = username
        self.usernameIsValid = validationService.username(username)
        let error = usernameIsValid ? nil : "DNI not valid"
        completion(error)
    }
    func validate(password: String?, completion: @escaping (String?) -> Void) {
        self.password = password
        self.passwordIsValid = validationService.string(password)
        let error = passwordIsValid ? nil : "Password it's empty"
        completion(error)
    }
    func formIsValid(completion: @escaping (Bool) -> Void) {
        completion(usernameIsValid && passwordIsValid)
    }
    
    func login(completion: @escaping (Result<Bool, ErrorMessage>) -> Void) {
        guard let username = username, let password = password else { return }
        
        loginService.login(username: username, password: password) { result in
            switch result {
            case .success(let data):
                self.saveToken(data.tokenCredential)
                completion(.success(true))
            case .failure:
                completion(.failure("Login data is not correct"))
            }
        }
    }
    
    func logout() {
        keychain.remove(key: KeychainKey.authToken)
    }
}

private extension LoginInteractor {
    func saveToken(_ token: String) {
        keychain.save(key: KeychainKey.authToken, string: token)
    }
}
