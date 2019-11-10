import UIKit

class CardTableViewCell: UITableViewCell {

    static let cellId = String(describing: CardTableViewCell.self)

    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    func configure(with card: CardEntity) {
        aliasLabel.text = card.alias
        panLabel.text = card.pan
        balanceLabel.text = "\(card.avalaible.value) \(card.avalaible.currency)"
        balanceLabel.textColor = card.avalaible.isPositive ? .gray : .red
    }
}
