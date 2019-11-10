import Foundation

protocol RequestManagerType {
    func requestEntity<T: Decodable>(resource: ResourceType, completion: @escaping  (Result<T, Error>) -> Void)
}

class RequestManager: RequestManagerType {
    
    static let shared = RequestManager()
    
    private init(){}
    
    func requestEntity<T: Decodable>(resource: ResourceType, completion: @escaping (Result<T, Error>) -> Void) {
        self.request(resource: resource) { result in
            switch result {
            case .success(let data):
                if let entity = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(entity))
                } else {
                    print("ERROR: \(Errors.wrongJSONFormat("\(T.self)"))")
                    completion(.failure(Errors.wrongJSONFormat("\(T.self)")))
                }
            case .failure(let error):
                print("ERROR: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func request(resource: ResourceType, completion: @escaping (Result<Data, Error>) -> Void) {
        if Config.appConnectionMode == .localMocks, let dataMock = resource.dataMock {
            return completion(.success(dataMock))
        }
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue

        if let headers = resource.headers {
            headers.forEach({request.addValue($0.value, forHTTPHeaderField: $0.key)})
        }
        if let params = resource.parameters,
            let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])  {
            request.httpBody = httpBody
        }

        print("REQUEST: \(request)")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("RESPONSE: \(String(describing: response)), DATA: \(String(describing: String(data: data, encoding: .utf8)))")
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else if let error = error {
                print("RESPONSE: \(String(describing: response)), ERROR: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
