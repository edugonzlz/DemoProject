import Foundation

struct Config {
    
    enum ConnectionMode {
        case network
        case localMocks
    }
    
    static var appConnectionMode: ConnectionMode = .localMocks
}
