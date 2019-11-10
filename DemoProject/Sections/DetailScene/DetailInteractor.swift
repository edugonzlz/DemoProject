import Foundation

struct DetailItem {
    let name: String
    let id: String
    let balance: String
}

protocol DetailInteractorType: class {
    func getData() -> DetailItem?
}

class DetailInteractor {

    var account: AccountEntity? = nil
    var card: CardEntity? = nil
}

extension DetailInteractor: DetailInteractorType {
    func getData() -> DetailItem? {
        if let item = account {
            return DetailItem(name: item.alias, id: item.IBAN, balance: "\(item.balance.value) \(item.balance.currency)")
        } else if let item = card {
            return DetailItem(name: item.alias, id: item.pan, balance: "\(item.avalaible.value) \(item.avalaible.currency)")
        }
        return nil
    }
}

