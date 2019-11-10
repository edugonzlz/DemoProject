import Foundation

protocol UserServiceType {
    func getUser(completion: @escaping (Result<UserEntity, Error>) -> Void)
    
}

class UserService {
    
    private let requestManager: RequestManagerType
    
    init(requestManager: RequestManagerType) {
        self.requestManager = requestManager
    }
}

extension UserService: UserServiceType {
    func getUser(completion: @escaping (Result<UserEntity, Error>) -> Void) {
        guard var url = URL(string: URLConstants.host) else {
            preconditionFailure("Failed to construct URL")
        }
        url.appendPathComponent(URLConstants.globalposition)
        
        let authToken = KeychainManager().get(key: KeychainKey.authToken)
        var resource = Resource(method: .get, url: url, parameters: nil, headers: ["tokenCredential": authToken ?? ""])
        resource.dataMock = getDataFromFile(named: "userEntityMock")
        
        requestManager.requestEntity(resource: resource) { (result :Result<UserEntity, Error>) in
            completion(result)
        }
    }
}
