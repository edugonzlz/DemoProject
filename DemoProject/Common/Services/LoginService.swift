import Foundation

protocol LoginServiceType {
    func login(username: String, password: String, completion: @escaping (Result<LoginEntity, Error>) -> Void)
}

class LoginService {
    
    private let requestManager: RequestManagerType
    
    init(requestManager: RequestManagerType) {
        self.requestManager = requestManager
    }
}

extension LoginService: LoginServiceType {
    func login(username: String, password: String, completion: @escaping (Result<LoginEntity, Error>) -> Void) {
        guard var url = URL(string: URLConstants.host) else {
            preconditionFailure("Failed to construct URL")
        }
        url.appendPathComponent(URLConstants.login)
        
        let params = ["user": username,
                      "password": password]
        var resource = Resource(method: .post, url: url, parameters: params, headers: nil)
        
        if username == "50289527G", password == "1234" {
            resource.dataMock = getDataFromFile(named: "loginEntityMock")
        }
        
        requestManager.requestEntity(resource: resource) { (result: Result<LoginEntity, Error>) in
            completion(result)
        }
    }
}
