import Foundation

struct BalanceEntity: Codable {
    let value: String
    let currency: String
    
    var isPositive: Bool {
        return !value.contains("-")
    }
}
