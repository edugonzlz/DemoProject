import Foundation

struct UserEntity: Codable {
    let name: String
    let accounts: [AccountEntity]
    let cards: [CardEntity]
}
