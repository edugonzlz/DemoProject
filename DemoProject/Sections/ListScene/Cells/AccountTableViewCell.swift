import UIKit

class AccountTableViewCell: UITableViewCell {

    static let cellId = String(describing: AccountTableViewCell.self)
    
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var IBANLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func configure(with account: AccountEntity) {
        aliasLabel.text = account.alias
        IBANLabel.text = account.IBAN
        balanceLabel.text = "\(account.balance.value) \(account.balance.currency)"
        balanceLabel.textColor = account.balance.isPositive ? .gray : .red
    }
    
}
