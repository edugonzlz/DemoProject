import Foundation

protocol ListInteractorType: class {
    func getUser(completion: @escaping (Result<UserEntity, ErrorMessage>) -> Void)
}

class ListInteractor {

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }
}

extension ListInteractor: ListInteractorType {
    func getUser(completion: @escaping (Result<UserEntity, ErrorMessage>) -> Void) {
        userService.getUser { (result: Result<UserEntity, Error>) in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure:
                completion(.failure("Something has gone wrong"))
            }
        }
    }
}
