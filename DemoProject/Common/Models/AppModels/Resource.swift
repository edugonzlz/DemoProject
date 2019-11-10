import Foundation

protocol ResourceType {
    var method: HTTPMethod { get }
    var url: URL { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    var dataMock: Data? { get }
}

struct Resource: ResourceType {
    var method: HTTPMethod
    var url: URL
    var parameters: [String: Any]?
    var headers: [String: String]?
    
    var dataMock: Data? = nil

    init(method: HTTPMethod, url: URL, parameters: [String: Any]?, headers: [String: String]?) {
        self.method = method
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
