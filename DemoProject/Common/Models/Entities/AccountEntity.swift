import Foundation

class AccountEntity: Codable {
    let IBAN: String
    var alias: String
    let balance: BalanceEntity
}
